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

variable "Business_Division" {
  description = "business division infra belong to"
  type = string
  default = "SAP"
}
variable "Environment" {
  description = "Environment to describe what environment it is"
  default = "Dev"
}
variable "resoruce_group_name" {
  description = "this the resource group that will be used to create all the object"
  default = "rg-default"
}
variable "resource_group_loation"{
  description = "Location detal"
  default = "eastus2"
}

locals {
  owners = var.Business_Division
  environment = var.Environment
  resource_name_profix = "${var.Business_Division}- ${var.Environment}"
  common_tag ={
    owners = locals.owners
    environment = locals.environment
  }
}


