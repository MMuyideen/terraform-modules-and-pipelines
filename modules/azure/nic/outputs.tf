output "id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.nic.id
}

output "name" {
  description = "The name of the network interface"
  value       = azurerm_network_interface.nic.name
}

output "private_ip_address" {
  description = "The primary private IP address of the network interface"
  value       = azurerm_network_interface.nic.private_ip_address
}
