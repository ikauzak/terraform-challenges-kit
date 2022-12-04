# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
resource "azurerm_service_plan" "lab" {
  name                = "lab-appservice-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "S1"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
resource "azurerm_linux_web_app" "lab" {
  name                = "lab-appservice"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.lab.id
  app_settings = {
    ConnectionStrings__PoupaDevCs = local.db_connection_string
  }

  site_config {
    application_stack {
      docker_image     = "ikauzak/poupadev-api"
      docker_image_tag = "v1.0.1"
    }
  }

  tags = {
    terraform = "true"
  }

  # Somente necessário ao provisionar o banco
  connection_string {
    # Connection string não aceita "-", por isso é necessário o replace por "_"
    name  = replace(azurerm_mssql_server.lab_database.name, "-", "_")
    type  = "SQLServer"
    value = azurerm_mssql_server.lab_mssql_server.fully_qualified_domain_name
  }
}
