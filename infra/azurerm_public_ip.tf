resource "azurerm_public_ip" "pip_vmweb1_1" {
  name                = "pip-vmweb1-1"
  location            = data.azurerm_resource_group.rg_web_1.location
  resource_group_name = data.azurerm_resource_group.rg_web_1.name
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = "Basic"
}