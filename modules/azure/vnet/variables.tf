variable "name" {
  description = "The name of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual network will be created"
  type        = string
}

variable "address_space" {
  description = "A list of address spaces for the virtual network (e.g., [\"10.0.0.0/16\"])"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnets to create in the virtual network"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "tags" {
  description = "A map of tags to assign to the virtual network"
  type        = map(string)
  default     = {}
}
