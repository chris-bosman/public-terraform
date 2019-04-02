terraform {
    backend "azurerm" {}
}

data "azurerm_key_vault" "deployment" {
  name                = "pi-${var.env_shorthand}-kv"
  resource_group_name = "pi-vaults-rg"
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
  end_date              = "2020-01-01T00:00:00Z"
}