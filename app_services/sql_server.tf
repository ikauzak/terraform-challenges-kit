variable "db_name" {
  type    = string
  default = "lab-mssql-server-masuda"
}

# todo
#
# ajustar nome de lab_database para lab_mssql_server
resource "azurerm_mssql_server" "lab_database" {
  name                          = random_password.db_pass.keepers.database
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  version                       = "12.0"
  administrator_login           = "mainadministrator"
  administrator_login_password  = random_password.db_pass.result
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true
}

# regra para possibilitar a chamadas de origem azure
resource "azurerm_mssql_firewall_rule" "internet" {
  name             = "internet-all-ingress"
  server_id        = azurerm_mssql_server.lab_database.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database" "lab_database" {
  name           = "lab-db"
  server_id      = azurerm_mssql_server.lab_database.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 5
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
  override_special = "?!@^{}[];:*()+="
  keepers = {
    database = var.db_name
  }
}

