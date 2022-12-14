# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.29.0"
    }
  }
  #  https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
  backend "azurerm" {
    resource_group_name  = "masudalabs-blob-storage"
    storage_account_name = "masudalabs"
    container_name       = "masudalabs"
    key                  = "app_services.terraform.tfstate"
  }

  # Versão requisitada pelo terraform
  required_version = ">= 1.1.0"
}

# Força a destruição de do resource group mesmo se há outros recursos criados
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "main" {
  name     = "masudalabs-app-services"
  location = "eastus2"

  tags = {
    manager = "terraform"
  }
}

locals {
  # Criar string de conexão dot Net "Server=algumacoisa.com;Database=teste-db;User ID=admin;Password=teste123"
  db_connection_string = "Server=${azurerm_mssql_server.lab_database.fully_qualified_domain_name};Database=${azurerm_mssql_database.lab_database.name};User ID=${azurerm_mssql_server.lab_database.administrator_login};Password=${random_password.db_pass.result};"
}
