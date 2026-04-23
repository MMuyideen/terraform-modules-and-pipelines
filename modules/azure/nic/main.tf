

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
  # We use a static string "enabled" as the key. 
  # Terraform knows the string "enabled" at plan time!
  for_each = var.nsg_id != null ? { "enabled" = var.nsg_id } : {}

  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = each.value # This is the actual nsg_id
}
