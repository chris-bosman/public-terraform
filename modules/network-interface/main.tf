terraform {
    backend "azurerm" {}
}
data "azurerm_resource_group" "deployment" {
    name    = "${var.resource_group_name}"
}

data "azurerm_subnet" "deployment" {
  name                  = "${var.subnet_name}"
  resource_group_name   = "${data.azurerm_resource_group.deployment.name}"
  virtual_network_name  = "${data.azurerm_virtual_network.deployment.name}"
}

data "azurerm_network_security_group" "deployment" {
  name                = "${var.security_group_name}"
  resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

resource "azurerm_network_interface" "deployment" {
  name                      = "${var.network_interface_name}"
  location                  = "${data.azurerm_resource_group.deployment.location}"
  resource_group_name       = "${data.azurerm_resource_group.deployment.name}"
  network_security_group_id = "${data.azurerm_network_security_group.deployment.id}"

  ip_configuration {
    name                          = "${var.ip_config_name}"
    subnet_id                     = "${data.azurerm_subnet.deployment.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${data.azurerm_public_ip.deployment.id}"
  }

  tags {
    environment     = "${var.environment}"
    department      = "${var.department}"
    service         = "Networking"
    component       = "Network Interface"
  }
}