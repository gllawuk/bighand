resource "azurerm_managed_disk" "vmsql1_datadisk_0" {
  name                 = "${var.disk_db_name}_0"
  location             = data.azurerm_resource_group.rg_data_1.location
  resource_group_name  = data.azurerm_resource_group.rg_data_1.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
}

resource "azurerm_managed_disk" "vmsql1_datadisk_1" {
  name                 = "${var.disk_db_name}_1"
  location             = data.azurerm_resource_group.rg_data_1.location
  resource_group_name  = data.azurerm_resource_group.rg_data_1.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
}
