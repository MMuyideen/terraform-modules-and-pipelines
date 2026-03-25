output "id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.this.id
}

output "ip_address" {
  description = "The IP address associated with the public IP"
  value       = azurerm_public_ip.this.ip_address
}

output "fqdn" {
  description = "The fully qualified domain name (FQDN) of the public IP"
  value       = azurerm_public_ip.this.fqdn
}
