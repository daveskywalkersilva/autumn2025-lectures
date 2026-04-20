# Tools Registry

## start_azure_vm

**Schema:** `start_vm.json`  
**Implementation:** `start_vm.ps1`  
**Metadata:** `start_vm.metadata.json`  
**Skill:** `.agents/skills/azure-vm-control/SKILL.md`

### Definition
- **Category:** Infrastructure Control
- **Severity:** High
- **Idempotent:** Yes

### Preconditions
- Managed identity has Virtual Machine Contributor role
- VM must be deallocated or stopped

### Side Effects
- Modifies cloud state (irreversible)
- Incurs compute costs
- Applications may need initialization time

### Best Practices
See `.agents/skills/azure-vm-control/SKILL.md` for when and how to use this tool.