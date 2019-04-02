output "id" {
    value = "${azurerm_network_interface.deployment.id}"
}
output "mac_address" {
    value = "${azurerm_network_interface.deployment.mac_address}"
}
output "private_ip_address" {
    value = "${azurerm_network_interface.deployment.private_ip_address}"
}
output "virtual_machine_id" {
    value = "${azurerm_network_interface.deployment.virtual_machine_id}"
}