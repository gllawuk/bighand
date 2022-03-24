variable "windows_admin_username" {
  description = "Windows administrator username"
  type        = string
}

variable "windows_admin_password" {
  description = "Windows administrator password"
  type        = string
}

variable "rg_vnet_name" {
  description = ""
  type        = string
}

variable "rg_db_name" {
  description = ""
  type        = string
}

variable "rg_app_name" {
  description = ""
  type        = string
}

variable "vnet_name" {
  description = ""
  type        = string
}

variable "snet_db_name" {
  description = ""
  type        = string
}

variable "snet_app_name" {
  description = ""
  type        = string
}

variable "nic_db_name" {
  description = ""
  type        = string
}

variable "nic_db_ip_address" {
  description = ""
  type        = string
}

variable "nic_app_name" {
  description = ""
  type        = string
}

variable "nic_app_ip_address" {
  description = ""
  type        = string
}

variable "vm_db_name" {
  description = ""
  type        = string
}

variable "vm_db_size" {
  description = ""
  type        = string
}

variable "vm_app_name" {
  description = ""
  type        = string
}

variable "vm_app_size" {
  description = ""
  type        = string
}
