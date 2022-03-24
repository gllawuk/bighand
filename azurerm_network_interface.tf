resource "azurerm_network_interface" "nic_vmsql_1" {
  name                = var.nic_db_name
  location            = data.azurerm_resource_group.rg_data_1.location
  resource_group_name = data.azurerm_resource_group.rg_data_1.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.snet_data_uks_1.id
    primary                       = true
    private_ip_address            = var.nic_db_ip_address
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
  }
}

resource "azurerm_network_interface" "nic_vmapp1_1" {
  name                = var.nic_app_name
  location            = data.azurerm_resource_group.rg_app_1.location
  resource_group_name = data.azurerm_resource_group.rg_app_1.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.snet_app_uks_1.id
    primary                       = true
    private_ip_address            = var.nic_app_ip_address
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
  }
}
