output "id" {
  description = "The ID of the virtual machine"
  value       = local.vm_id
}

output "public_ip_address" {
  description = "The public IP address associated with the virtual machine (if any)"
  value       = var.os_type == "linux" ? try(azurerm_linux_virtual_machine.this[0].public_ip_address, null) : try(azurerm_windows_virtual_machine.this[0].public_ip_address, null)
}

output "private_ip_address" {
  description = "The private IP address of the virtual machine"
  value       = var.os_type == "linux" ? try(azurerm_linux_virtual_machine.this[0].private_ip_address, null) : try(azurerm_windows_virtual_machine.this[0].private_ip_address, null)
}

output "admin_username" {
  description = "The username of the administrator account"
  value       = var.admin_username
}
