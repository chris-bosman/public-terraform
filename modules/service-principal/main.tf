terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "kv" {
  name    = "${var.vault_resource_group_name}"
}

data "azurerm_key_vault" "deployment" {
  name                = "${var.key_vault_name}"
  resource_group_name = "${data.azurerm_resource_group.kv.name}"
}

resource "azurerm_azuread_application" "deployment" {
  name        = "${var.service_principal_name}"
}

resource "azurerm_azuread_service_principal" "deployment" {
  application_id  = "${azurerm_azuread_application.deployment.application_id}"
}

resource "azurerm_azuread_service_principal_password" "deployment" {
  service_principal_id  = "${azurerm_azuread_service_principal.deployment.id}"
  value                 = "${data.azurerm_key_vault_secret.deployment.value}"
  end_date              = "${var.password_expiration_date}"
}