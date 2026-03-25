variable "name" {
  description = "The name of the storage account (must be globally unique and contain only lowercase letters and numbers)"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the storage account will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the storage account will be created"
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account ('Standard' or 'Premium')"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "The replication type for the storage account (e.g., 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS', 'RAGZRS')"
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

variable "tags" {
  description = "A map of tags to assign to the storage account"
  type        = map(string)
  default     = {}
}
