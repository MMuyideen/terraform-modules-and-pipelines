variable "name" {
  description = "The name of the network interface"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the NIC will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the NIC will be created"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to attach the NIC to"
  type        = string
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address to assign to the NIC (optional)"
  type        = string
  default     = null
}

variable "nsg_id" {
  description = "The ID of the network security group to associate with the NIC (optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the network interface"
  type        = map(string)
  default     = {}
}
