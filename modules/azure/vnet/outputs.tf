output "id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "A map of subnet names to their IDs"
  value = {
    for subnet in azurerm_subnet.this : subnet.name => subnet.id
  }
}
