
variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}
# -------------------
# Resource Group
# -------------------

variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
}
variable "location" {
  description = "The Azure region where the resource group will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the network security group"
  type        = map(string)
  default     = {}
}

# --------------------------
# Virtual Network & Subnet
# -------------------------

variable "vnet_name" {
  description = "The name of the Azure virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space of the Azure virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnets to create within the virtual network"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

# --------------------------
# NSG
# -------------------------

variable "nsg_name" {
  description = "The name of the Azure network security group"
  type        = string
}

variable "security_rule" {
  description = "A list of inbound security rules to create"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []

}

# --------------------------
# Storage Account
# -------------------------

variable "storage_account_name" {
  description = "The name of the Azure storage account (must be globally unique and contain only lowercase letters and numbers)"
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

# --------------------------
# NIC
# -------------------------

variable "nic_name" {
  description = "The name of the Azure network interface"
  type        = string
}

variable "pip_name" {
  description = "The name of the Azure public IP address"
  type        = string
}

variable "allocation_method" {
  description = "The allocation method for the public IP address"
  type        = string
  default     = "Static"
}

variable "domain_name_label" {
  description = "The domain name label for the public IP address (optional)"
  type        = string
  default     = null
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone"
  type        = string
}

variable "dns_records" {
  description = "A list of DNS records to create in the private DNS zone"
  type = list(object({
    name    = string
    type    = string
    ttl     = optional(number, 3600)
    records = optional(list(string), [])
  }))
  default = []
}
