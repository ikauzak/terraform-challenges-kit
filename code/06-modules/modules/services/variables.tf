variable "service_name" {
  type        = string
  description = "Nome do serviço a ser criado"
}

variable "service_location" {
  type        = string
  description = "Nome da localização do serviço"
}

variable "service_resource_group_name" {
  type        = string
  description = "Nome do resource group"
}

variable "service_extra_tags" {
  type        = map(string)
  default     = {}
  description = "Map com chave e valor para tags"
}

variable "docker_image" {
  type        = string
  description = "Nome de uma imagem no formato image:tag"
}

variable "db_white_list" {
  type        = map(string)
  description = "Dicionário com nome da regra e o ip a ser liberado"
  default     = {}
}

variable "db_username" {
  type    = string
  default = "mainadministrator"
}

variable "vault_id" {
  type        = string
  description = "O ID do vault onde será gravado credenciais do db server"
}

variable "environment" {
  type        = string
  description = "Ambiente prod/dev"
}
