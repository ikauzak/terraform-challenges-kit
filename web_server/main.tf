# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.29.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "main" {
  name     = "masudalabs-eastus2"
  location = "eastus2"

  tags = {
    manager = "terraform"
  }
}

resource "azurerm_virtual_network" "main-network" {
  name                = "main-network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.100.0.0/16"]
}

resource "azurerm_subnet" "main-subnet" {
  name                 = "main-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main-network.name
  address_prefixes     = ["10.100.0.0/27"]
}

resource "azurerm_public_ip" "main-ext-ip" {
  name                = "main-gateway-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "main-gateway" {
  name                = "main-nat-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "main-association" {
  nat_gateway_id       = azurerm_nat_gateway.main-gateway.id
  public_ip_address_id = azurerm_public_ip.main-ext-ip.id
}

resource "azurerm_subnet_nat_gateway_association" "main-subnet-association" {
  subnet_id      = azurerm_subnet.main-subnet.id
  nat_gateway_id = azurerm_nat_gateway.main-gateway.id
}

resource "azurerm_network_security_group" "main-nsg" {
  name                = "main-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_security_rule" "outbound" {
  name                        = "outbound-rule"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_address_prefix       = "*"
  destination_port_range      = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main-nsg.name
}

resource "azurerm_network_security_rule" "inbound" {
  name                        = "inbound-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_address_prefix       = "*"
  destination_port_range      = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main-nsg.name
}
