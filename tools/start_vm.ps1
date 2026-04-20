<#
.SYNOPSIS
    Start an Azure Virtual Machine
    
.DESCRIPTION
    Starts a stopped Azure VM in the specified resource group.
    
.DEFINITION
    Category: Infrastructure Control
    Severity: High
    Idempotency: Yes (safe to call multiple times)
    Rollback: Not possible (state change is permanent)
    
.PRECONDITIONS
    - Managed identity has Virtual Machine Contributor role
    - VM exists and is deallocated/stopped
    
.POSTCONDITIONS
    - VM enters running state
    - Compute charges resume
    
.SIDE_EFFECTS
    - Modifies cloud state (irreversible)
    - Incurs compute costs
    - Applications may need initialization time
    
.EXAMPLE
    .\start_vm.ps1 -subscription_id "12345678..." -resource_group "myRG" -vm_name "myVM"
#>

param(
    [string]$subscription_id,
    [string]$resource_group,
    [string]$vm_name,
    [bool]$wait_for_completion = $true
)

$startTime = Get-Date

try {
    # Step 1: Authenticate using managed identity (production) or stored credentials
    Write-Host "Authenticating to Azure..."
    Connect-AzAccount -Identity -ErrorAction Stop | Out-Null
    
    # Step 2: Set subscription context
    Set-AzContext -SubscriptionId $subscription_id -ErrorAction Stop | Out-Null
    
    # Step 3: Check if VM exists
    Write-Host "Checking if VM '$vm_name' exists in resource group '$resource_group'..."
    $vm = Get-AzVM -ResourceGroupName $resource_group -Name $vm_name -ErrorAction SilentlyContinue
    
    if ($null -eq $vm) {
        return @{
            status = "error"
            reason = "not_found"
            details = "VM '$vm_name' not found in resource group '$resource_group'"
            context = "Verify the VM name and resource group are correct"
        } | ConvertTo-Json
    }
    
    # Step 4: Check current VM state
    $vmStatus = Get-AzVM -ResourceGroupName $resource_group -Name $vm_name -Status -ErrorAction Stop
    $powerState = $vmStatus.Statuses | Where-Object { $_.Code -like "PowerState/*" } | Select-Object -ExpandProperty Code
    
    if ($powerState -eq "PowerState/running") {
        return @{
            status = "success"
            vm_name = $vm_name
            resource_group = $resource_group
            current_state = "running"
            details = "VM is already running"
            execution_time_ms = ([datetime]::UtcNow - $startTime).TotalMilliseconds
        } | ConvertTo-Json
    }
    
    # Step 5: Start the VM
    Write-Host "Starting VM '$vm_name'..."
    $startJob = Start-AzVM -ResourceGroupName $resource_group -Name $vm_name -NoWait -ErrorAction Stop
    
    if ($wait_for_completion) {
        Write-Host "Waiting for VM to start..."
        $startJob | Wait-Job -ErrorAction Stop | Out-Null
        
        # Verify final state
        $vmStatusFinal = Get-AzVM -ResourceGroupName $resource_group -Name $vm_name -Status -ErrorAction Stop
        $finalPowerState = $vmStatusFinal.Statuses | Where-Object { $_.Code -like "PowerState/*" } | Select-Object -ExpandProperty Code
        
        if ($finalPowerState -eq "PowerState/running") {
            return @{
                status = "success"
                vm_name = $vm_name
                resource_group = $resource_group
                current_state = "running"
                details = "VM started successfully"
                execution_time_ms = ([datetime]::UtcNow - $startTime).TotalMilliseconds
            } | ConvertTo-Json
        } else {
            return @{
                status = "error"
                reason = "start_failed"
                details = "VM start command executed but VM did not reach running state. Current state: $finalPowerState"
                execution_time_ms = ([datetime]::UtcNow - $startTime).TotalMilliseconds
            } | ConvertTo-Json
        }
    } else {
        return @{
            status = "success"
            vm_name = $vm_name
            resource_group = $resource_group
            current_state = "starting"
            details = "Start command submitted asynchronously"
            job_id = $startJob.Id
            execution_time_ms = ([datetime]::UtcNow - $startTime).TotalMilliseconds
        } | ConvertTo-Json
    }
    
} catch [Microsoft.Azure.Commands.Compute.Common.ComputeCloudException] {
    if ($_.Exception.Message -like "*does not have authorization*") {
        return @{
            status = "error"
            reason = "forbidden"
            details = "Insufficient permissions to start VM"
            required_role = "Virtual Machine Contributor"
            execution_time_ms = ([datetime]::UtcNow - $startTime).TotalMilliseconds
        } | ConvertTo-Json
    }
} catch {
    return @{
        status = "error"
        reason = "execution_failed"
        details = $_.Exception.Message
        execution_time_ms = ([datetime]::UtcNow - $startTime).TotalMilliseconds
    } | ConvertTo-Json
}