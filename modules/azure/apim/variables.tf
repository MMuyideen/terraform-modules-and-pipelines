variable "name" {
  description = "The name of the API Management service"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the API Management service will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the API Management service will be created"
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher of the API Management service"
  type        = string
}

variable "publisher_email" {
  description = "The email address of the publisher of the API Management service"
  type        = string
}

variable "sku_name" {
  description = "The SKU of the API Management service (e.g., 'Developer_1', 'Standard_1', 'Premium_1')"
  type        = string
  default     = "Developer_1"
}

variable "virtual_network_type" {
  description = "The virtual network type for the API Management service ('None', 'External', or 'Internal')"
  type        = string
  default     = "None"

  validation {
    condition     = contains(["None", "External", "Internal"], var.virtual_network_type)
    error_message = "virtual_network_type must be 'None', 'External', or 'Internal'."
  }
}

variable "virtual_network_configuration" {
  description = "Virtual network configuration for the API Management service (required when virtual_network_type is not 'None')"
  type = object({
    subnet_id = string
  })
  default = null
}

variable "tags" {
  description = "A map of tags to assign to the API Management service"
  type        = map(string)
  default     = {}
}
