terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
    name = "${var.resource_group_name}"
}

data "azurerm_virtual_network" "deployment" {
    name                = "${var.virtual_network_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

resource "azurerm_subnet" "deployment" {
    name                        = "${var.subnet_name}"
    resource_group_name         = "${data.azurerm_resource_group.deployment.name}"
    virtual_network_name        = "${var.virtual_network_name}"
    address_prefix              = "${var.subnet_address_space}"
}