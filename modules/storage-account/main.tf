terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
    name = "${var.resource_group_name}"
}

resource "azurerm_storage_account" "deployment" {
    name                        = "${var.storage_account_name}"
    resource_group_name         = "${data.azurerm_resource_group.deployment.name}"
    location                    = "${data.azurerm_resource_group.deployment.location}"
    account_tier                = "${var.storage_tier}"
    account_replication_type    = "${var.storage_replication_type}"

    tags {
        environment = "${var.environment}"
        department  = "${var.department}"
        service     = "Storage"
        component   = "Storage Account"
        function    = "${var.storage_function_name}"
    }
}