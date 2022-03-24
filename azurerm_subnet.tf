data "azurerm_subnet" "snet_data_uks_1" {
  name                 = var.snet_db_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.rg_gw_1.name
}

data "azurerm_subnet" "snet_app_uks_1" {
  name                 = var.snet_app_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.rg_gw_1.name
}
