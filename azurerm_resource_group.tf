data "azurerm_resource_group" "rg_vnet" {
  name = var.rg_vnet_name
}

data "azurerm_resource_group" "rg_db" {
  name = var.rg_db_name
}

data "azurerm_resource_group" "rg_app" {
  name = var.rg_app_name
}
