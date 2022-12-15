locals {
  full_vault_name = "${random_id.vault_key_name.keepers.vault}-${random_id.vault_key_name.hex}-${var.vault_environment}"

  full_tags = merge( {manager="Terraform", environment=var.vault_environment}, var.vault_extra_tags)
}

data "azurerm_client_config" "current" {}

resource "random_id" "vault_key_name" {
  keepers = {
    vault = "${var.vault_name}"
  }
  byte_length = 4
}

resource "azurerm_key_vault" "lab" {
  name                       = local.full_vault_name
  location                   = var.vault_location
  resource_group_name        = var.vault_resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = var.vault_soft_delete_retention_days

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "List"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
  }

  tags = local.full_tags

  # feature para terraform 1.2.0 >
  #  lifecycle {
  #    precondition {
  #      condition = length(self.name) <= 24
  #      error_message = "O nome completo do Vault deve ter menos que 24 carácteres: ${local.full_vault_name} = ${length(self.name)}"
  #    }
  #  }
}
