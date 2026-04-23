variable "name" {
  description = "The name of the private DNS zone"
  type        = string
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

variable "dns_records" {
  description = "A list of DNS records to create in the zone"
  type = map(object({
    name    = string
    type    = string
    ttl     = optional(number, 3600)
    records = optional(list(string), [])
  }))
}

variable "tags" {
  description = "A map of tags to assign to the DNS zone"
  type        = map(string)
  default     = {}
}
