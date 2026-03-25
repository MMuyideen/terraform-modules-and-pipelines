terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

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
  count                     = var.nsg_id != null ? 1 : 0
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = var.nsg_id
}
