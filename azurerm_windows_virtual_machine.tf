resource "azurerm_windows_virtual_machine" "vm_db" {
  name                = var.vm_db_name
  location            = data.azurerm_resource_group.rg_db.location
  resource_group_name = data.azurerm_resource_group.rg_db.name
  size                = var.vm_db_size
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  license_type        = "Windows_Server"
  network_interface_ids = [
    azurerm_network_interface.nic_db.id,
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

resource "azurerm_windows_virtual_machine" "vm_app" {
  name                = var.vm_app_name
  location            = data.azurerm_resource_group.rg_app.location
  resource_group_name = data.azurerm_resource_group.rg_app.name
  size                = var.vm_app_size
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  network_interface_ids = [
    azurerm_network_interface.nic_app.id,
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
