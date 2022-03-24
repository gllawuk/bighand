data "azurerm_subnet" "snet_db" {
  name                 = var.snet_db_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_subnet" "snet_app" {
  name                 = var.snet_app_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}
