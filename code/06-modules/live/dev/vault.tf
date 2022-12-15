module "vault" {
  source = "../../modules/azure-vault"

  vault_name                       = "masuda"
  vault_environment                = var.environment
  vault_location                   = azurerm_resource_group.main.location
  vault_resource_group_name        = azurerm_resource_group.main.name
  vault_soft_delete_retention_days = 10
}

