variable "name" {
  description = "The name of the network security group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the NSG will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the NSG will be created"
  type        = string
}

variable "inbound_rules" {
  description = "A list of inbound security rules to create"
  type = list(object({
    name                   = string
    priority               = number
    destination_port_range = string
    protocol               = optional(string, "Tcp")
    source_address_prefix  = optional(string, "*")
    access                 = optional(string, "Allow")
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the network security group"
  type        = map(string)
  default     = {}
}
