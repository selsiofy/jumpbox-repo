resource "azurerm_virtual_machine" "vm-01" {
  name                  = "vm-name"
  resource_group_name   = data.azurerm_resource_group.bastion.name
  location              = data.azurerm_resource_group.bastion.location
  vm_size               = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.Bastion_network_interface.id]
  os_profile {
   computer_name  = var.comp_name
   admin_username = var.comp_usr_name
   admin_password = var.comp_usr_pass
  }
  storage_os_disk {
    name              = "vm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
  }
  os_profile_linux_config {
   disable_password_authentication = false
}
}

resource "azurerm_virtual_machine_extension" "aad" {
  name                       = var.extention_name
  publisher                  = "Microsoft.Azure.ActiveDirectory.LinuxSSH"
  type                       = "AADLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  virtual_machine_id         = azurerm_virtual_machine.vm-01.id
}

resource "azurerm_network_interface" "Bastion_network_interface" {
  name                =  "nic-bastion-${local.environments_short}-${local.location_short}-01"
  location                      = data.azurerm_resource_group.bastion.location
  resource_group_name           = data.azurerm_resource_group.bastion.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.Azure_Bastion_Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    data.azurerm_virtual_network.vnet,
    data.azurerm_subnet.Azure_Bastion_Subnet
  ]
}

resource "azurerm_public_ip" "bastion_ip" {
  name                = "pip-bastion-${local.environments_short}-${local.location_short}-01"
  resource_group_name           = data.azurerm_resource_group.bastion.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = local.zones
  tags = {
    Environment = local.environment
  }
}


resource "azurerm_bastion_host" "app_bastion" {
  name                   = "bas-rome-${local.environments_short}-${local.location_short}-01"
  location               = data.azurerm_resource_group.bastion.location
  resource_group_name    = data.azurerm_resource_group.bastion.name
  sku                    = "Standard"
  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.Azure_Bastion_Subnet.name
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}
