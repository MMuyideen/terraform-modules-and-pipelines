variable "name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the VM will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the VM will be created"
  type        = string
}

variable "size" {
  description = "The size of the virtual machine (e.g., 'Standard_B2s', 'Standard_D2s_v3')"
  type        = string
}

variable "admin_username" {
  description = "The username of the administrator account on the virtual machine"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "The password for the administrator account. Required for Windows VMs and Linux VMs without SSH keys"
  type        = string
  sensitive   = true
  default     = null
}

variable "ssh_public_key" {
  description = "The public SSH key for Linux VM authentication (required when disable_password_authentication is true)"
  type        = string
  sensitive   = true
  default     = null
}

variable "network_interface_ids" {
  description = "A list of network interface IDs to attach to the virtual machine"
  type        = list(string)
}

variable "os_type" {
  description = "The operating system type for the virtual machine ('linux' or 'windows')"
  type        = string
  default     = "linux"

  validation {
    condition     = contains(["linux", "windows"], lower(var.os_type))
    error_message = "os_type must be either 'linux' or 'windows'."
  }
}

variable "source_image_reference" {
  description = "The source image reference for the virtual machine. If not specified, sensible defaults will be used based on os_type"
  type = object({
    publisher = optional(string)
    offer     = optional(string)
    sku       = optional(string)
    version   = optional(string)
  })
  default = {}
}

variable "os_disk" {
  description = "The operating system disk configuration"
  type = object({
    caching              = optional(string, "ReadWrite")
    storage_account_type = optional(string, "Standard_LRS")
  })
  default = {}
}

variable "custom_data" {
  description = "Custom data to pass to the virtual machine (cloud-init for Linux or custom scripts for Windows)"
  type        = string
  sensitive   = true
  default     = null
}

variable "disable_password_authentication" {
  description = "Whether to disable password authentication for Linux VMs (requires ssh_public_key)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the virtual machine"
  type        = map(string)
  default     = {}
}
