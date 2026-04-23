output "id" {
  description = "The ID of the API Management service"
  value       = azurerm_api_management.this.id
}

output "name" {
  description = "The name of the API Management service"
  value       = azurerm_api_management.this.name
}

output "gateway_url" {
  description = "The gateway URL of the API Management service"
  value       = azurerm_api_management.this.gateway_url
}

output "private_ip_addresses" {
  description = "The private IP addresses of the API Management service"
  value       = azurerm_api_management.this.private_ip_addresses
}

output "developer_portal_url" {
  description = "The developer portal URL of the API Management service"
  value       = azurerm_api_management.this.developer_portal_url
}
