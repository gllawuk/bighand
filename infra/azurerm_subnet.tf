data "azurerm_subnet" "snet_app_uks_1" {
  name = "snet-app-uks-1"
  virtual_network_name = "vnet-uks-1"
  resource_group_name = data.azurerm_resource_group.rg_gw_1.name
}

data "azurerm_subnet" "snet_data_uks_1" {
  name = "snet-data-uks-1"
  virtual_network_name = "vnet-uks-1"
  resource_group_name = data.azurerm_resource_group.rg_gw_1.name
}

data "azurerm_subnet" "snet_web_uks_1" {
   name = "snet-web-uks-1"
  virtual_network_name = "vnet-uks-1"
  resource_group_name = data.azurerm_resource_group.rg_gw_1.name 
}