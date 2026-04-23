

resource "azurerm_network_interface" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }

  tags = var.tags
}

# Associate the network security group with the network interface if provided
resource "azurerm_network_interface_security_group_association" "this" {
  # If nsg_id is null, the set is empty (0 resources). 
  # If it has a value, the set has one item (1 resource).
  for_each = var.nsg_id != null ? toset([var.nsg_id]) : []

  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = each.value # each.value is the nsg_id
}
