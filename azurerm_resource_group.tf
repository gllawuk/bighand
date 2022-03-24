data "azurerm_resource_group" "rg_gw_1" {
  name = var.rg_vnet_name
}

data "azurerm_resource_group" "rg_data_1" {
  name = var.rg_db_name
}

data "azurerm_resource_group" "rg_app_1" {
  name = var.rg_app_name
}
