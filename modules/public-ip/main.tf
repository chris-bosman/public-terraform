terraform {
    backend "azurerm" {}
}
data "azurerm_resource_group" "deployment" {
    name    = "${var.resource_group_name}"
}

resource "azurerm_public_ip" "deployment" {
  name                         = "${var.public_ip_name}"
  location                     = "${data.azurerm_resource_group.deployment.location}"
  resource_group_name          = "${data.azurerm_resource_group.deployment.name}"
  public_ip_address_allocation = "dynamic"

  tags {
      environment       = "${var.environment}"
      department        = "${var.department}"
      service           = "Networking"
      component         = "Public IP"
  }
}