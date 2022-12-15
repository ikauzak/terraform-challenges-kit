variable "vault_location" {
  type        = string
  description = "Localização do Vault Azure"
}

variable "vault_resource_group_name" {
  type        = string
  description = "Nome do resource group"
}

variable "vault_soft_delete_retention_days" {
  type        = number
  default     = 7
  description = "Número de dias de retenção de soft delete"
}

variable "vault_name" {
  type        = string
  description = "Nome do vault a ser criado"
}

variable "vault_environment" {
  type        = string
  description = "Nome do ambiente, exemplo prod/dev"
}

variable "vault_extra_tags" {
  type = map(string)
  default = {}
  description = "Map com chave e valor para tags"
}
