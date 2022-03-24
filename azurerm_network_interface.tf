resource "azurerm_network_interface" "nic_db" {
  name                = var.nic_db_name
  location            = data.azurerm_resource_group.rg_db.location
  resource_group_name = data.azurerm_resource_group.rg_db.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.snet_db.id
    primary                       = true
    private_ip_address            = var.nic_db_ip_address
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
  }
}

resource "azurerm_network_interface" "nic_app" {
  name                = var.nic_app_name
  location            = data.azurerm_resource_group.rg_app.location
  resource_group_name = data.azurerm_resource_group.rg_app.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.snet_app.id
    primary                       = true
    private_ip_address            = var.nic_app_ip_address
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
  }
}
