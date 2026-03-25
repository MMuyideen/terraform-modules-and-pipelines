variable "name" {
  description = "The name of the Azure Front Door CDN profile"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the CDN profile will be created"
  type        = string
}

variable "sku_name" {
  description = "The SKU of the Azure Front Door profile (e.g., 'Standard_AzureFrontDoor', 'Premium_AzureFrontDoor')"
  type        = string
  default     = "Standard_AzureFrontDoor"

  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.sku_name)
    error_message = "sku_name must be either 'Standard_AzureFrontDoor' or 'Premium_AzureFrontDoor'."
  }
}

variable "tags" {
  description = "A map of tags to assign to the CDN profile"
  type        = map(string)
  default     = {}
}
