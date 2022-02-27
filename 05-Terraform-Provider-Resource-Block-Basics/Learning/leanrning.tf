#terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=2.0.0"
    }
  }
}
#provider block for 1
provider "azurerm" {
features {}
  # Configuration options
}

#provider block for 2
provider "azurerm" {
features {
 virtual_machine {
   delete_os_disk_on_deletion = false
 }
}
alias = "provider2-westus"
  
}

resource "azurerm_resource_group" "myrg1" {
  name = "my-rg1"
  location = "East US"
}

resource "azurerm_resource_group" "myrg2" {
  name = "my-rg2"
  location = "West US"
  provider = azurerm.provider2-westus
  
}


