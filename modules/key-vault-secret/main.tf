terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
    name    = "${var.resource_group_name}"
}

data "azurerm_key_vault" "deployment" {
    name                = "${var.key_vault_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

resource "azurerm_key_vault_secret" "deployment" {
    name        = "${var.secret_name}"
    value       = "${var.secret_value}"
    vault_uri   = "${data.azurerm_key_vault.deployment.vault_uri}"

    tags {
        environment = "${var.environment}"
        department  = "${var.department}"
        service     = "Security"
        component   = "Secret"
    }
}