

resource "azurerm_public_ip" "this" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  domain_name_label   = var.domain_name_label

  tags = var.tags
}
