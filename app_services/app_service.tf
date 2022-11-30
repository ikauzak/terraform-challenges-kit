locals {
  db_connection_string = "Server=${azurerm_mssql_server.lab_database.fully_qualified_domain_name};Database=${azurerm_mssql_database.lab_database.name};User ID=${azurerm_mssql_server.lab_database.administrator_login};Password=${random_password.db_pass.result};"
}

resource "azurerm_service_plan" "lab" {
  name                = "lab-appservice-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "lab" {
  name                = "lab-appservice"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.lab.id
  app_settings = {
    ConnectionStrings__PoupaDevCs = local.db_connection_string
    #    MSSQL_CONNECTION = azurerm_mssql_server.lab_database.fully_qualified_domain_name
    #    MSSQL_USER       = azurerm_mssql_server.lab_database.administrator_login
    #    MSSQL_PASS       = random_password.db_pass.result
    #    MSSQL_DB         = azurerm_mssql_database.lab_database.name
  }

  site_config {
    application_stack {
      docker_image     = "ikauzak/poupadev-api"
      docker_image_tag = "v1.1.0"
    }
  }
  tags = {
    terraform = "true"
  }

  connection_string {
    name  = replace(azurerm_mssql_server.lab_database.name, "-", "_")
    type  = "SQLServer"
    value = azurerm_mssql_server.lab_database.fully_qualified_domain_name
  }
}

output "appservice_address" {
  value = "App Service URL: https://${azurerm_linux_web_app.lab.default_hostname}"
}
