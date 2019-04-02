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

data "azurerm_azuread_service_principal" "deployment" {
    display_name = "${var.service_principal_name}"
}

resource "azurerm_key_vault_access_policy" "deployment" {
    vault_name      = "${data.azurerm_key_vault.deployment.name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"

    tenant_id       = "${var.tenant_id}"
    object_id       = "${data.azurerm_azuread_service_principal.deployment.id}"

    certificate_permissions = "${var.certificate_permissions}"

    key_permissions = "${var.key_permissions}"

    secret_permissions = "${var.secret_permissions}"
}