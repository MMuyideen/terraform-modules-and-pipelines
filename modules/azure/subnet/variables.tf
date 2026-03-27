variable "name" {
  description = "The name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network the subnet belongs to"
  type        = string
}

variable "address_prefixes" {
  description = "A list of address prefixes for the subnet (e.g., [\"10.0.1.0/24\"])"
  type        = list(string)
}
