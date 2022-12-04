# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
resource "azurerm_mssql_server" "lab_mssql_server" {
  name                          = var.db_name
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  version                       = "12.0"
  administrator_login           = "mainadministrator"
  administrator_login_password  = "teste123"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database
resource "azurerm_mssql_database" "lab_database" {
  name           = "lab-db"
  server_id      = azurerm_mssql_server.lab_mssql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 5
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}

# regra para possibilitar a chamadas de origem azure
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule
resource "azurerm_mssql_firewall_rule" "internet" {
  name             = "internet-all-ingress"
  server_id        = azurerm_mssql_server.lab_database.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
