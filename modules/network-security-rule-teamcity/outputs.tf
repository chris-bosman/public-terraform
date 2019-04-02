output "inbound_rule_id" {
    value = "${azurerm_network_security_rule.inbound.id}"
}

output "outbound_rule_id" {
    value = "${azurerm_network_security_rule.outbound.id}"
}