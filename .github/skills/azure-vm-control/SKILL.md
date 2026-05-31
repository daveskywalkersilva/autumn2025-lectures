---
name: azure-vm-control
description: Best practices and guidance for safely starting/stopping Azure Virtual Machines
---

# Azure VM Control Skill

## When to Use This Skill

Use this skill when an agent needs to:
- Start or stop Azure VMs for maintenance
- Restart VMs that are unresponsive
- Scale infrastructure up/down based on demand
- Recover from application failures by restarting

## Best Practices

### 1. Always Check VM State First
Before attempting to start a VM, verify:
- Current power state (running, stopped, deallocated)
- If already running, don't restart unnecessarily
- If deallocated, be aware it may take 2-3 minutes to start

### 2. Understand Billing Impact
- **Deallocated VMs**: You stop paying for compute (only storage charged)
- **Stopped VMs**: You still pay for compute
- Always deallocate when not in use for extended periods

### 3. Verify Permissions
Ensure the managed identity has **Virtual Machine Contributor** role on:
- The specific VM resource, OR
- The resource group, OR
- The subscription (least recommended)

### 4. Plan for Downtime
- Starting a VM takes 2-3 minutes
- Applications may take additional time to initialize
- Use `wait_for_completion=true` for dependent tasks

### 5. Handle Dependent Services
Starting a VM doesn't automatically start services. Agent should:
1. Start the VM (this tool)
2. Wait 30 seconds
3. Check if application services are running
4. Restart services if needed

## Common Pitfalls

❌ **Mistake:** Repeatedly restarting without checking logs
→ **Fix:** Read application logs first to diagnose the actual issue

❌ **Mistake:** Starting VMs during peak hours without capacity planning
→ **Fix:** Check quotas and regional capacity before start commands

❌ **Mistake:** Assuming `wait_for_completion=false` means the VM is ready
→ **Fix:** Use polling tools to check actual running state

## Tool Output Interpretation

| Status | Meaning | Agent Should Do |
|--------|---------|-----------------|
| `success` + `running` | VM is running | Proceed with next task |
| `success` + `starting` | Start command queued | Wait and poll for actual running state |
| `error` + `not_found` | VM doesn't exist | Check spelling and resource group |
| `error` + `forbidden` | Permission denied | Request appropriate RBAC role |
| `error` + `start_failed` | VM didn't reach running state | Check VM diagnostic logs for boot errors |

## Related Skills & Tools

- **Azure VM Diagnostics Skill**: Troubleshoot why a VM won't start
- Tool: `check_vm_diagnostics()` - Get boot logs
- Tool: `deallocate_vm()` - Stop VM to save costs
- Tool: `restart_vm()` - Quick restart (not stop + start)