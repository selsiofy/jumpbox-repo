data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "bastion" {
  name = var.resource_group_name
}

data "azurerm_subnet" "Azure_Bastion_Subnet" {
  name                 = "AzureBastiuonSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

data "azurerm_subnet" "vm_subnet" {
 name                  = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

data "azurerm_virtual_network" "vnet" {
  name                = "vnet-name"
  resource_group_name  = var.resource_group_name  
#subnet {
 #   name           = "AzureBastionSubnet"
    #address_prefix = 
  #}
}


locals {
locations_short = {
    #locations
  }

  environments_short = {
   #env
  }
#location_short    = 
#environment       = 
#environment_short = 
#zones             = 
}
