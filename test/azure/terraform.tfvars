
resource_group_name = "deen-test-rg"
location            = "eastus"
vnet_name           = "deen-test-vnet"
address_space       = ["10.0.0.0/16"]
subnets = [
  {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  },
  {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
  }
]

nsg_name = "deen-test-nsg"
security_rule = [
  {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-SQL"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Deny-RDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

storage_account_name     = "deentest"
account_tier             = "Standard"
account_replication_type = "LRS"

nic_name          = "deen-test-nic"
pip_name          = "deen-test-pip"
allocation_method = "Static"
domain_name_label = "deen-test-pip"

private_dns_zone_name = "deentestprivatednszone.com"
dns_records = [
  {
    name    = "test-a"
    type    = "A"
    ttl     = 3600
    records = ["10.0.1.10"]
  },
]