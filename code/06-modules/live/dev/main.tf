terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.29.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }

  backend "azurerm" {
    resource_group_name  = "masudalabs-blob-storage"
    storage_account_name = "masudalabs"
    container_name       = "masudalabs"
    key                  = "dev.terraform.tfstate"
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
  name     = "masudalabs-${var.environment}"
  location = "eastus2"

  tags = {
    manager     = "terraform"
    environment = var.environment
  }
}

