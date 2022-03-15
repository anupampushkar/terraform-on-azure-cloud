#terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=2.0.0"
    }
     random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }

  }
}

provider "azurerm" {
  
}
provider "random" {
  # Configuration options
}
resource "azurerm_resource_group" "myrg1" {
    name = "my-rg1"
    location = "East US"
}
resource "random_string" "myrandom" {
  length = 16
  special = false
  upper = false
}
resource "azurerm_storage_account" "example" {
  name                     = "sa${random_string.myrandom.id}"
  resource_group_name      = azurerm_resource_group.myrg1.name
  location                 = azurerm_resource_group.myrg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_encryption_source = "Microsoft.Storage"

  tags = {
    environment = "staging"
  }
}

