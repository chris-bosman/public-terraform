output "id" {
    value = "${azurerm_app_service.deployment.id}"
}

output "default_site_hostname" {
    value = "${azurerm_app_service.deployment.default_site_hostname}"
}

output "location" {
    value = "${azurerm_app_service.deployment.location}"
}

output "name" {
    value = "${azurerm_app_service.deployment.name}"
}