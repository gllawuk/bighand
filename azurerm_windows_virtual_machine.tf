# sql
resource "azurerm_windows_virtual_machine" "vmsql1" {
  name                = "vmsql1"
  location            = data.azurerm_resource_group.rg_data_1.location
  resource_group_name = data.azurerm_resource_group.rg_data_1.name
  size                = "Standard_B2ms"
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  license_type        = "Windows_Server"
  network_interface_ids = [
    azurerm_network_interface.nic_vmsql_1.id,
  ]

  boot_diagnostics {}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "microsoftsqlserver"
    offer     = "sql2019-ws2019"
    sku       = "standard"
    version   = "latest"
  }

  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
}

# bighand
resource "azurerm_windows_virtual_machine" "vmapp1" {
  name                = "vmapp1"
  location            = data.azurerm_resource_group.rg_app_1.location
  resource_group_name = data.azurerm_resource_group.rg_app_1.name
  size                = "Standard_B2s"
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  network_interface_ids = [
    azurerm_network_interface.nic_vmapp1_1.id,
  ]

  boot_diagnostics {}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
}