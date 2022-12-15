module "app1" {
  source = "../../modules/services"

  service_name                = "masudalabs-app01"
  service_location            = azurerm_resource_group.main.location
  service_resource_group_name = azurerm_resource_group.main.name
  environment                 = var.environment
  docker_image                = "ikauzak/poupadev-api:v1.1.0"

  db_white_list = {
    internet = "0.0.0.0"
  }

  vault_id = module.vault.id
}

module "app2" {
  source = "../../modules/services"

  service_name                = "masuda02-teste"
  service_location            = azurerm_resource_group.main.location
  service_resource_group_name = azurerm_resource_group.main.name
  environment                 = var.environment
  docker_image                = "ikauzak/poupadev-api:v1.1.0"

  db_white_list = {
    internet = "0.0.0.0"
  }

  vault_id = module.vault.id
}

module "app3" {
  source = "../../modules/services"

  service_name                = "masuda044-novo"
  service_location            = azurerm_resource_group.main.location
  service_resource_group_name = azurerm_resource_group.main.name
  environment                 = var.environment
  docker_image                = "ikauzak/poupadev-api:v1.1.0"

  db_white_list = {
    internet = "0.0.0.0"
  }

  service_extra_tags = {
    owner = "masuda"
    area  = "marketing"
  }

  vault_id = module.vault.id
}
