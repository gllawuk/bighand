resource "azurerm_network_interface" "nic_vmsql_1" {
  name                = "nic-vmsql-1" # Missing number, should be "nic-vmsql1-1"
  location            = data.azurerm_resource_group.rg_data_1.location
  resource_group_name = data.azurerm_resource_group.rg_data_1.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.snet_data_uks_1.id
    primary                       = true
    private_ip_address            = "10.1.2.5"
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
  }
}

resource "azurerm_network_interface" "nic_vmapp1_1" {
  name                = "nic-vmapp1-1"
  location            = data.azurerm_resource_group.rg_app_1.location
  resource_group_name = data.azurerm_resource_group.rg_app_1.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.snet_app_uks_1.id
    primary                       = true
    private_ip_address            = "10.1.3.4"
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
  }
}