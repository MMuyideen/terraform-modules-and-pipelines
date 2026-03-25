variable "name" {
  description = "The name of the public IP"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the public IP will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the public IP will be created"
  type        = string
}

variable "allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic"
  type        = string
  default     = "Dynamic"

  validation {
    condition     = contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "allocation_method must be either 'Static' or 'Dynamic'."
  }
}

variable "tags" {
  description = "A map of tags to assign to the public IP"
  type        = map(string)
  default     = {}
}
