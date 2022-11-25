resource "azurerm_network_interface" "webserver" {
  name                = "webserver-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webserver-public-ip.id
  }
}

resource "azurerm_linux_virtual_machine" "webserver" {
  name                            = "webserver"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_D2as_v4"
  admin_username                  = "adminuser"
  admin_password                  = "Teste@123!"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.webserver.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "webserver-public-ip" {
  name                = "webserver-public-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface_security_group_association" "webserver-nsg" {
  network_interface_id      = azurerm_network_interface.webserver.id
  network_security_group_id = azurerm_network_security_group.main-nsg.id
}
