resource "azurerm_virtual_machine_data_disk_attachment" "vmsql1_to_vmsql1_datadisk_0" {
  managed_disk_id    = azurerm_managed_disk.vmsql1_datadisk_0.id
  virtual_machine_id = azurerm_windows_virtual_machine.vmsql1.id
  lun                = "0"
  caching            = "ReadOnly"
}

resource "azurerm_virtual_machine_data_disk_attachment" "vmsql1_to_vmsql1_datadisk_1" {
  managed_disk_id    = azurerm_managed_disk.vmsql1_datadisk_1.id
  virtual_machine_id = azurerm_windows_virtual_machine.vmsql1.id
  lun                = "1"
  caching            = "None"
}
