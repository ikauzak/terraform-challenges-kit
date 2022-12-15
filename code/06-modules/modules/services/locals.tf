locals {
  full_name = "${var.service_name}-${var.environment}"

  # somando dois dicionários em um único dict
  full_tags = merge({ manager = "Terraform", environment = var.environment }, var.service_extra_tags)

  # usando split para separar a string image:tag em lista ["image", "tag"]
  service_docker = split(":", var.docker_image)

  # string de conexão do banco a ser passado para a app
  db_connection_string = "Server=${azurerm_mssql_server.lab_dbserver.fully_qualified_domain_name};Database=${azurerm_mssql_database.lab_database.name};User ID=${azurerm_mssql_server.lab_dbserver.administrator_login};Password=${random_password.db_pass.result};"
}

