output "id" {
  description = "The ID of the Azure Front Door CDN profile"
  value       = azurerm_cdn_frontdoor_profile.this.id
}

output "name" {
  description = "The name of the Azure Front Door CDN profile"
  value       = azurerm_cdn_frontdoor_profile.this.name
}
