resource "azurerm_mssql_server" "lab_dbserver" {
  name                          = "${local.full_name}-db"
  location                      = var.service_location
  resource_group_name           = var.service_resource_group_name
  version                       = "12.0"
  administrator_login           = var.db_username
  administrator_login_password  = random_password.db_pass.result
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true
  tags                          = local.full_tags
}

# regra para possibilitar a chamadas de origem azure
resource "azurerm_mssql_firewall_rule" "db_white_list" {
  for_each         = var.db_white_list
  name             = each.key
  server_id        = azurerm_mssql_server.lab_dbserver.id
  start_ip_address = each.value
  end_ip_address   = each.value
}

resource "azurerm_mssql_database" "lab_database" {
  name           = "default-db"
  server_id      = azurerm_mssql_server.lab_dbserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = var.environment == "prod" ? 10 : 5
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}

resource "random_password" "db_pass" {
  length           = 24
  special          = true
  min_special      = 3
  min_numeric      = 4
  min_upper        = 4
  override_special = "?!@^{}[]*()+="
}

resource "azurerm_key_vault_secret" "mssql_database_pass" {
  name         = "${azurerm_mssql_server.lab_dbserver.name}-password"
  value        = azurerm_mssql_server.lab_dbserver.administrator_login_password
  key_vault_id = var.vault_id
  tags         = local.full_tags
}

resource "azurerm_key_vault_secret" "mssql_database_user" {
  name         = "${azurerm_mssql_server.lab_dbserver.name}-username"
  value        = azurerm_mssql_server.lab_dbserver.administrator_login
  key_vault_id = var.vault_id
  tags         = local.full_tags
}
