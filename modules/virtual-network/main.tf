terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
  name = "${var.resource_group_name}"
}

resource "azurerm_virtual_network" "deployment" {
  name                = "${var.virtual_network_name}"
  address_space       = "${var.virtual_network_address_space}"
  location            = "${data.azurerm_resource_group.deployment.location}"
  resource_group_name = "${data.azurerm_resource_group.deployment.name}"

  tags {
    environment     = "${var.environment}"
    department      = "${var.department}"
    service         = "Networking"
    component       = "Virtual Network"
  }
}