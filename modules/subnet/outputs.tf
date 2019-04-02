output "id" {
    value = "${azurerm_subnet.deployment.id}"
}

output "name" {
    value = "${azurerm_subnet.deployment.name}"
}

output "resource_group_name" {
    value = "${azurerm_subnet.deployment.resource_group_name}"
}

output "virtual_network_name" {
    value = "${azurerm_subnet.deployment.virtual_network_name}"
}

output "address_prefix" {
    value = "${azurerm_subnet.deployment.address_prefix}"
}