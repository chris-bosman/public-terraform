terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
    name    = "${var.resource_group_name}"
}

data "azurerm_network_security_group" "deployment" {
    name                = "${var.security_group_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

resource "azurerm_network_security_rule" "inbound" {
  name                        = "teamcity-inbound"
  resource_group_name         = "${data.azurerm_resource_group.deployment.name}"
  network_security_group_name = "${data.azurerm_network_security_group.deployment.name}"

  priority                   = 101
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "TCP"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "${var.team_city_ip}"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "outbound" {
  name                        = "teamcity-outbound"
  resource_group_name         = "${data.azurerm_resource_group.deployment.name}"
  network_security_group_name = "${data.azurerm_network_security_group.deployment.name}"

  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "9090"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "${var.team_city_ip}"
}