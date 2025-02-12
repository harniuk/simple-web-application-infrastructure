terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.18.0"
    }
  }
  required_version = "1.9.8"

  backend "azurerm" {
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "tfbackend15117"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}

}