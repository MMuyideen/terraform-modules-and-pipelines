output "id" {
  description = "The ID of the Azure resource group"
  value       = azurerm_resource_group.this.id
}

output "name" {
  description = "The name of the Azure resource group"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "The location of the Azure resource group"
  value       = azurerm_resource_group.this.location
}
