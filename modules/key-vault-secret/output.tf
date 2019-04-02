output "id" {
    value = "${azurerm_key_vault_secret.deployment.id}"
}

output "version" {
    value = "${azurerm_key_vault_secret.deployment.version}"
}