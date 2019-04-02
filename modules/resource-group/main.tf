terraform {
    backend "azurerm" {}
}

resource "azurerm_resource_group" "deployment" {
    name        = "${var.resource_group_name}"
    location    = "${var.location}"

    tags {
        environment = "${var.environment}"
        department  = "${var.department}"
    }
}