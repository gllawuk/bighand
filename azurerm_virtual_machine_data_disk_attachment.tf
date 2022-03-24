resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment_0" {
  managed_disk_id    = azurerm_managed_disk.data_disk_0.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm_db.id
  lun                = "0"
  caching            = "ReadOnly"
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment_1" {
  managed_disk_id    = azurerm_managed_disk.data_disk_1.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm_db.id
  lun                = "1"
  caching            = "None"
}
