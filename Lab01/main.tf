# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "patito" {
  name     = "iacPrueba"
  location = "centralus"
  tags = {
    "Env" = "Dev"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "iacvnet"
  location            = azurerm_resource_group.patito.location
  resource_group_name = azurerm_resource_group.patito.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "iacsubnet"
  resource_group_name  = azurerm_resource_group.patito.name
  address_prefixes     = ["10.0.0.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet.name

}
