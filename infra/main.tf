terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2" # Europe (London)
}

provider "azurerm" {
  features {}
}

# resource groups
data "azurerm_resource_group" "rg_gw_1" {
  name = "rg-gw-1"
}

data "azurerm_resource_group" "rg_app_1" {
  name = "rg-app-1"
}

data "azurerm_resource_group" "rg_data_1" {
  name = "rg-data-1"
}

data "azurerm_resource_group" "rg_web_1" {
  name = "rg-web-1"
}

# subnets
data "azurerm_subnet" "snet_app_uks_1" {
  name = "snet-app-uks-1"
  virtual_network_name = "vnet-uks-1"
  resource_group_name = data.azurerm_resource_group.rg_gw_1.name
}

data "azurerm_subnet" "snet_data_uks_1" {
  name = "snet-data-uks-1"
  virtual_network_name = "vnet-uks-1"
  resource_group_name = data.azurerm_resource_group.rg_gw_1.name
}

data "azurerm_subnet" "snet_web_uks_1" {
   name = "snet-web-uks-1"
  virtual_network_name = "vnet-uks-1"
  resource_group_name = data.azurerm_resource_group.rg_gw_1.name 
}

# pip
resource "azurerm_public_ip" "pip_vmweb1_1" {
  name                = "pip-vmweb1-1"
  location            = data.azurerm_resource_group.rg_web_1.location
  resource_group_name = data.azurerm_resource_group.rg_web_1.name
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = "Basic"
}

# nics
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

resource "azurerm_network_interface" "nic_vmweb1_1" {
  name                = "nic-vmweb1-1"
  location            = data.azurerm_resource_group.rg_web_1.location
  resource_group_name = data.azurerm_resource_group.rg_web_1.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.snet_web_uks_1.id
    primary                       = true
    private_ip_address            = "10.1.4.4"
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.pip_vmweb1_1.id
  }
}

# virtual machines
# mssql
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

resource "azurerm_managed_disk" "vmsql1_datadisk_0" {
  name                 = "vmsql1_DataDisk_0"
  location             = data.azurerm_resource_group.rg_data_1.location
  resource_group_name  = data.azurerm_resource_group.rg_data_1.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
}

resource "azurerm_managed_disk" "vmsql1_datadisk_1" {
  name                 = "vmsql1_DataDisk_1"
  location             = data.azurerm_resource_group.rg_data_1.location
  resource_group_name  = data.azurerm_resource_group.rg_data_1.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
}

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

# bighand server
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

# bighand go server
resource "azurerm_windows_virtual_machine" "vmweb1" {
  name                = "vmweb1"
  location            = data.azurerm_resource_group.rg_web_1.location
  resource_group_name = data.azurerm_resource_group.rg_web_1.name
  size                = "Standard_B2s"
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  network_interface_ids = [
    azurerm_network_interface.nic_vmweb1_1.id,
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

data "aws_route53_zone" "gregglatchams_com" {
  name = "gregglatchams.com"
}

# record
resource "aws_route53_record" "gregglatchams_com_pip_vmweb1_1" {
  zone_id = data.aws_route53_zone.gregglatchams_com.id
  name    = "pip-vmweb1-1.gregglatchams.com"
  type    = "A"
  ttl     = "300"
  records = [azurerm_public_ip.pip_vmweb1_1.ip_address]
}

resource "aws_route53_record" "gregglatchams_com_bighand" {
  zone_id = data.aws_route53_zone.gregglatchams_com.id
  name    = "bighand.gregglatchams.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_route53_record.gregglatchams_com_pip_vmweb1_1.fqdn]
}