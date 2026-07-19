module "resource_group" {
  source              = "../../modules/azure/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vnet" {
  source              = "../../modules/azure/vnet"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = module.resource_group.name
  subnets             = var.subnets
}

module "nsg" {
  source              = "../../modules/azure/nsg"
  nsg_name            = var.nsg_name
  location            = var.location
  resource_group_name = module.resource_group.name
  security_rule       = var.security_rule
  tags                = var.tags
}

module "storage_account" {
  source                   = "../../modules/azure/storage-account"
  storage_account_name     = var.storage_account_name
  resource_group_name      = module.resource_group.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

module "nic" {
  source                 = "../../modules/azure/nic"
  nic_name               = var.nic_name
  location               = var.location
  resource_group_name    = module.resource_group.name
  subnet_id              = module.vnet.subnet_ids[0]
  nsg_id                 = module.nsg.nsg_id
  create_nsg_association = true
}

module "public_ip" {
  source              = "../../modules/azure/public-ip"
  pip_name            = var.pip_name
  location            = var.location
  resource_group_name = module.resource_group.name
  allocation_method   = var.allocation_method
  domain_name_label   = var.domain_name_label
}

module "dns_zone" {
  source                = "../../modules/azure/dns-zone"
  private_dns_zone_name = var.private_dns_zone_name
  resource_group_name   = module.resource_group.name
  virtual_network_id    = module.vnet.id
  create_vnet_link      = true
  dns_records           = var.dns_records
  tags                  = var.tags
}