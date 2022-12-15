resource "azurerm_service_plan" "main" {
  name                = "${local.full_name}-plan"
  location            = var.service_location
  resource_group_name = var.service_resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "main" {
  name                = "${local.full_name}-app"
  location            = var.service_location
  resource_group_name = var.service_resource_group_name
  service_plan_id     = azurerm_service_plan.main.id
  app_settings = {
    ConnectionStrings__PoupaDevCs = local.db_connection_string
  }

  site_config {
    application_stack {
      # consumindo a lista local.service_docker
      docker_image     = local.service_docker[0]
      docker_image_tag = local.service_docker[1]
    }
  }

  tags = local.full_tags

}
