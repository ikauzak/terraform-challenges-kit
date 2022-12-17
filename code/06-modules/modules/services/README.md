<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.29.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.29.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.mssql_database_pass](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.mssql_database_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_web_app.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_mssql_database.lab_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_firewall_rule.db_white_list](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.lab_dbserver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_service_plan.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [random_password.db_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | n/a | `string` | `"mainadministrator"` | no |
| <a name="input_db_white_list"></a> [db\_white\_list](#input\_db\_white\_list) | Dicionário com nome da regra e o ip a ser liberado | `map(string)` | `{}` | no |
| <a name="input_docker_image"></a> [docker\_image](#input\_docker\_image) | Nome de uma imagem no formato image:tag | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Ambiente prod/dev | `string` | n/a | yes |
| <a name="input_service_extra_tags"></a> [service\_extra\_tags](#input\_service\_extra\_tags) | Map com chave e valor para tags | `map(string)` | `{}` | no |
| <a name="input_service_location"></a> [service\_location](#input\_service\_location) | Nome da localização do serviço | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Nome do serviço a ser criado | `string` | n/a | yes |
| <a name="input_service_resource_group_name"></a> [service\_resource\_group\_name](#input\_service\_resource\_group\_name) | Nome do resource group | `string` | n/a | yes |
| <a name="input_vault_id"></a> [vault\_id](#input\_vault\_id) | O ID do vault onde será gravado credenciais do db server | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appservice_address"></a> [appservice\_address](#output\_appservice\_address) | n/a |
| <a name="output_white_list"></a> [white\_list](#output\_white\_list) | n/a |
<!-- END_TF_DOCS -->