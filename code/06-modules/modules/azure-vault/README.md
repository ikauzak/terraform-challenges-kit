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
| [azurerm_key_vault.lab](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [random_id.vault_key_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vault_environment"></a> [vault\_environment](#input\_vault\_environment) | Nome do ambiente, exemplo prod/dev | `string` | n/a | yes |
| <a name="input_vault_extra_tags"></a> [vault\_extra\_tags](#input\_vault\_extra\_tags) | Map com chave e valor para tags | `map(string)` | `{}` | no |
| <a name="input_vault_location"></a> [vault\_location](#input\_vault\_location) | Localização do Vault Azure | `string` | n/a | yes |
| <a name="input_vault_name"></a> [vault\_name](#input\_vault\_name) | Nome do vault a ser criado | `string` | n/a | yes |
| <a name="input_vault_resource_group_name"></a> [vault\_resource\_group\_name](#input\_vault\_resource\_group\_name) | Nome do resource group | `string` | n/a | yes |
| <a name="input_vault_soft_delete_retention_days"></a> [vault\_soft\_delete\_retention\_days](#input\_vault\_soft\_delete\_retention\_days) | Número de dias de retenção de soft delete | `number` | `7` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Id do Azure Vault criado |
<!-- END_TF_DOCS -->
