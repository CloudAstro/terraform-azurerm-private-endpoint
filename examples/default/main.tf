resource "azurerm_resource_group" "example" {
  name     = "rg-privateendpoint-example"
  location = "germanywestcentral"
}

module "vnet" {
  source              = "CloudAstro/virtual-network/azurerm"
  name                = "vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.20.0.0/24"]
}


module "subnet" {
  source               = "CloudAstro/subnet/azurerm"
  name                 = "snet-example"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = module.vnet.virtual_network.name
  address_prefixes     = ["10.20.0.0/25"]
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacct111" # must be globally unique, lowercase
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_private_dns_zone" "example" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.example.name
}

module "private_endpoint" {
  source              = "../../"
  name                = "example-private-endpoint"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = module.subnet.subnet.id

  private_service_connection = {
    name                           = "example-connection"
    private_connection_resource_id = azurerm_storage_account.example.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}
