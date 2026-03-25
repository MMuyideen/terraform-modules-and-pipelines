terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Link the private DNS zone to a virtual network (if provided)
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  count = var.virtual_network_id != null ? 1 : 0

  name                  = "${var.name}-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = var.virtual_network_id
}

# Optionally create DNS records
resource "azurerm_private_dns_a_record" "this" {
  for_each = {
    for record in var.dns_records : "${record.name}-${record.type}" => record
    if record.type == "A"
  }

  name                = each.value.name
  zone_name           = azurerm_private_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 3600)
  records             = each.value.records
}

resource "azurerm_private_dns_cname_record" "this" {
  for_each = {
    for record in var.dns_records : "${record.name}-${record.type}" => record
    if record.type == "CNAME"
  }

  name                = each.value.name
  zone_name           = azurerm_private_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 3600)
  record              = each.value.records[0]
}

resource "azurerm_private_dns_mx_record" "this" {
  for_each = {
    for record in var.dns_records : "${record.name}-${record.type}" => record
    if record.type == "MX"
  }

  name                = each.value.name
  zone_name           = azurerm_private_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 3600)

  dynamic "record" {
    for_each = each.value.records
    content {
      preference = tonumber(split(" ", record.value)[0])
      exchange   = trimspace(split(" ", record.value)[1])
    }
  }
}

resource "azurerm_private_dns_txt_record" "this" {
  for_each = {
    for record in var.dns_records : "${record.name}-${record.type}" => record
    if record.type == "TXT"
  }

  name                = each.value.name
  zone_name           = azurerm_private_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 3600)

  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
}
