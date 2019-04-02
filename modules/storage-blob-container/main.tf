terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
    name = "${var.resource_group_name}"
}

data "azurerm_storage_account" "deployment" {
    name                = "${var.storage_account_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

resource "azurerm_storage_container" "deployment" {
    name                    = "${var.storage_container_name}"
    resource_group_name     = "${data.azurerm_resource_group.deployment.name}"
    storage_account_name    = "${data.azurerm_storage_account.deployment.name}"
    container_access_type   = "${var.storage_container_privacy}"
}