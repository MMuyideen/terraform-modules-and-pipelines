terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_rule" "inbound" {
  for_each = {
    for rule in var.inbound_rules : rule.name => rule
  }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = try(each.value.access, "Allow")
  protocol                    = try(each.value.protocol, "Tcp")
  source_port_range           = "*"
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = try(each.value.source_address_prefix, "*")
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}
