# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.29.0"
    }
  }

  #  https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
  #  backend "azurerm" {
  #    resource_group_name  = "masudalabs-blob-storage"
  #    storage_account_name = "masudalabs"
  #    container_name       = "masudalabs"
  #    key                  = "storage_container.terraform.tfstate"
  #  }

  # Verão requisitada pelo terraform
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
  name     = "masudalabs-blob-storage"
  location = "eastus2"

  tags = {
    manager = "terraform"
  }
}

