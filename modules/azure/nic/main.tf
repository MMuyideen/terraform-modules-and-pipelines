

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.nic_name}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }

  tags = var.tags
}

# Associate the network security group with the network interface if requested.
# Keyed on create_nsg_association (always known at plan time), not on nsg_id
# itself, since nsg_id is often an unknown-until-apply output of a sibling resource.
resource "azurerm_network_interface_security_group_association" "this" {
  for_each = var.create_nsg_association ? { "enabled" = var.nsg_id } : {}

  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = each.value # This is the actual nsg_id
}
