# Module for creating vnet and Subnet dynamically

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name           = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }

  tags = var.tags
}

