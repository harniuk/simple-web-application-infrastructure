variable "resource_group_name" {
  default = "my-rg"
}

variable "location" {
  default = "Poland Central"
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "azureuser"
}

variable "db_username" {
  default = "dbadmin"
}

variable "db_password" {}
variable "ssh_public_key" {}