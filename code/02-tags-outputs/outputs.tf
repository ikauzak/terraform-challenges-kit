output "appservice_address" {
  value = "App Service URL: https://${azurerm_linux_web_app.lab.default_hostname}"
}
