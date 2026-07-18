variable "private_dns_zone_name" {
  description = "The name of the private DNS zone"
  type        = string

  validation {
    condition     = length(split(".", var.private_dns_zone_name)) >= 2
    error_message = "private_dns_zone_name must have two or more labels separated by dots (e.g. \"example.internal\"), per Azure Private DNS zone naming rules."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group where the DNS zone will be created"
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to link to the DNS zone (optional)"
  type        = string
  default     = null
}

variable "create_vnet_link" {
  description = "Whether to link virtual_network_id to the DNS zone. Must be set explicitly (not derived from virtual_network_id) because that ID is often the computed output of a sibling resource and is not known until apply."
  type        = bool
  default     = false
}

variable "dns_records" {
  description = "A list of DNS records to create in the zone"
  type = list(object({
    name    = string
    type    = string
    ttl     = optional(number, 3600)
    records = optional(list(string), [])
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the DNS zone"
  type        = map(string)
  default     = {}
}
