output "id" {
    value = "${azurerm_public_ip.deployment.id}"
}
output "ip_address" {
    value = "${azurerm_public_ip.deployment.ip_address}"
}
output "fqdn" {
    value = "${azurerm_public_ip.deployment.fqdn}"
}