

# Deploy a Linux virtual machine when os_type is set to "linux"
# This resource uses count for conditional creation based on os_type variable
resource "azurerm_linux_virtual_machine" "this" {
  count = var.os_type == "linux" ? 1 : 0

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.size

  admin_username                  = var.admin_username
  disable_password_authentication = var.disable_password_authentication

  # Use either password or SSH key authentication
  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.ssh_public_key
    }
  }

  admin_password = !var.disable_password_authentication ? var.admin_password : null

  network_interface_ids = var.network_interface_ids

  os_disk {
    caching              = try(var.os_disk.caching, "ReadWrite")
    storage_account_type = try(var.os_disk.storage_account_type, "Standard_LRS")
  }

  source_image_reference {
    publisher = try(var.source_image_reference.publisher, "Canonical")
    offer     = try(var.source_image_reference.offer, "ubuntu-24_04-lts")
    sku       = try(var.source_image_reference.sku, "server")
    version   = try(var.source_image_reference.version, "latest")
  }

  # Optional custom data for cloud-init scripts
  custom_data = var.custom_data != null ? base64encode(var.custom_data) : null

  tags = var.tags
}

# Deploy a Windows virtual machine when os_type is set to "windows"
# This resource uses count for conditional creation based on os_type variable
resource "azurerm_windows_virtual_machine" "this" {
  count = var.os_type == "windows" ? 1 : 0

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.size

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = var.network_interface_ids

  os_disk {
    caching              = try(var.os_disk.caching, "ReadWrite")
    storage_account_type = try(var.os_disk.storage_account_type, "Standard_LRS")
  }

  source_image_reference {
    publisher = try(var.source_image_reference.publisher, "MicrosoftWindowsDesktop")
    offer     = try(var.source_image_reference.offer, "windows-11")
    sku       = try(var.source_image_reference.sku, "win11-24h2-pro")
    version   = try(var.source_image_reference.version, "latest")
  }

  # Optional custom data (for Windows, typically for WinRM or other setup scripts)
  custom_data = var.custom_data != null ? base64encode(var.custom_data) : null

  tags = var.tags
}

# Output the VM ID (works for both Linux and Windows due to count)
locals {
  vm_id = var.os_type == "linux" ? azurerm_linux_virtual_machine.this[0].id : azurerm_windows_virtual_machine.this[0].id
}
