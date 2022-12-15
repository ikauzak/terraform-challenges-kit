output "appservice_address" {
  value = "App Service URL: https://${azurerm_linux_web_app.main.default_hostname}/swagger"
}

output "white_list" {
  value = [for user, ip in var.db_white_list : "Usuário: ${user}|${ip}"]
}
