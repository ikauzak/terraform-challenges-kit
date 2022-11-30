data "azurerm_client_config" "current" {}

resource "random_id" "vault_key_name" {
  keepers = {
    vault = azurerm_resource_group.main.name
  }
  byte_length = 4
}

# todo
# vault keys são globais
# tamanho máximo do nome de vault 24 chars

resource "azurerm_key_vault" "lab" {
  name                       = "vault-lab-${random_id.vault_key_name.hex}"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

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
}

resource "azurerm_key_vault_secret" "mssql_database_pass" {
  name         = "${azurerm_mssql_server.lab_database.name}-pass"
  value        = azurerm_mssql_server.lab_database.administrator_login_password
  key_vault_id = azurerm_key_vault.lab.id
}

resource "azurerm_key_vault_secret" "mssql_database_user" {
  name         = "${azurerm_mssql_server.lab_database.name}-username"
  value        = azurerm_mssql_server.lab_database.administrator_login
  key_vault_id = azurerm_key_vault.lab.id
}
