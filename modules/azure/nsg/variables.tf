variable "nsg_name" {
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

variable "security_rule" {
  description = "A list of inbound security rules to create"
  type = list(object({
    name                   = string
    priority               = number
    destination_port_range = string
    protocol               = optional(string, "Tcp")
    direction              = optional(string, "Inbound")
    source_address_prefix  = optional(string, "*")
    access                 = optional(string, "Allow")
    source_port_range      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the network security group"
  type        = map(string)
  default     = {}
}
