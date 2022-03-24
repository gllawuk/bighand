resource "azurerm_managed_disk" "data_disk_0" {
  name                 = "${var.vm_db_name}_DataDisk_0"
  location             = data.azurerm_resource_group.rg_db.location
  resource_group_name  = data.azurerm_resource_group.rg_db.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
}

resource "azurerm_managed_disk" "data_disk_1" {
  name                 = "${var.vm_db_name}_DataDisk_1"
  location             = data.azurerm_resource_group.rg_db.location
  resource_group_name  = data.azurerm_resource_group.rg_db.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
}
