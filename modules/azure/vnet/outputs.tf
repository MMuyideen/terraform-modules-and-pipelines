output "id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "A list of subnet IDs, in the same order as the input `subnets` variable"
  value = [
    for s in var.subnets :
    { for subnet in azurerm_virtual_network.vnet.subnet : subnet.name => subnet.id }[s.name]
  ]
}
