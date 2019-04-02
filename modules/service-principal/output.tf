output "application_id" {
    value = "${azurerm_azuread_application.deployment.application_id}"
}

output "id" {
    value = "${azurerm_azuread_service_principal.deployment.id}"
}

output "display_name" {
    value = "${azurerm_azuread_service_principal.deployment.display_name}"
}

output "key_id" {
    value = "${azurerm_azuread_service_principal_password.deployment.id}"
}