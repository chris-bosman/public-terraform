output "id" {
    value = "${azurerm_key_vault.deployment.id}"
}

output "vault_uri" {
    value = "${azurerm_key_vault.deployment.vault_uri}"
}