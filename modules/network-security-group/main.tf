terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
    name    = "${var.resource_group_name}"
}

data "azurerm_virtual_network" "deployment" {
    name                = "${var.virtual_network_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

resource "azurerm_network_security_group" "deployment" {
  name                = "${var.security_group_name}"
  location            = "${data.azurerm_resource_group.deployment.location}"
  resource_group_name = "${data.azurerm_resource_group.deployment.name}"

  security_rule {
    name                       = "${var.is_os_windows == "1" ? "filtered-rdp" : "filtered-ssh"}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "${var.is_os_windows == "1" ? "3389" : "22"}"
    source_address_prefixes    = "${var.inbound_traffic_approved_ips}"
    destination_address_prefix = "*"
  }

  tags {
    environment     = "${var.environment}"
    department      = "${var.department}"
    parent_resource = "${data.azurerm_virtual_network.deployment.name}"
    service         = "Networking"
    component       = "Network Security Group"  
  }
}