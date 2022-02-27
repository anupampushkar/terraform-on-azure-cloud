# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.0" 
    }
  }
}

# Provider Block
provider "azurerm" {
 features {}          
}

#resoruce1
resource "azurerm_resource_group" "my-rg1" {
    name = "my-rg1"
    location = "East US"
  
}
#resoruce 2
resource "azurerm_virtual_network" "myvnet" {
    name = "myvnet-1"
    location = azurerm_resource_group.my-rg1.location
    address_space = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.my-rg1.name
    tags = {
        "name" = "myvnet-1"
    }  
}
#resoruce 3
resource "azurerm_subnet" "mysubnet" {
    name = "mysubet-1"
    resource_group_name = azurerm_resource_group.my-rg1.name
    virtual_network_name = virtual_network_name.myvnet.name
    address_prefixes = ["10.0.2.0/24"]
}

#resoruce 4
resource "azurerm_public_ip" "mypublicip" {
    name ="mypublicip-1"
    resource_group_name = azurerm_resource_group.my-rg1.name
    location= azurerm_resource_group.my-rg1.location
    allocallocation_method = Static
    tags = {
        "env" = "Prod"
    }

}
#resouce 5
resource "azurerm_network_interface" "myvmnic" {
    name = "myvmnic-1"
    location = azurerm_resource_group.my-rg1.location
    resource_group_name = azurerm_resource_group.my-rg1.name
    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.mysubnet.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.mypublicip.id

    }

  
}