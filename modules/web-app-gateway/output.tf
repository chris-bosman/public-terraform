output "id" {
    value = "${azurerm_application_gateway.deployment.id}"
}
output "authentication_certificate" {
    value = "${azurerm_application_gateway.deployment.authentication_certificate}"
}
output "backend_address_pool" {
    value = "${azurerm_application_gateway.deployment.backend_address_pool}"
}
output "backend_http_settings" {
    value = "${azurerm_application_gateway.deployment.backend_http_settings}"
}
output "frontend_ip_configuration" {
    value = "${azurerm_application_gateway.deployment.frontend_ip_configuration}"
}
output "frontend_port" {
    value = "${azurerm_application_gateway.deployment.frontend}"
}
output "gateway_ip_configuration" {
    value = "${azurerm_application_gateway.deployment.gateway_ip_configuration}"
}
output "http_listener" {
    value = "${azurerm_application_gateway.deployment.http_listener}"
}
output "probe" {
    value = "${azurerm_application_gateway.deployment.probe}"
}
output "request_routing_rule" {
    value = "${azurerm_application_gateway.deployment.request_routing_rule}"
}
output "ssl_certificate" {
    value = "${azurerm_application_gateway.deployment.ssl_certificate}"
}
output "url_path_map" {
    value = "${azurerm_application_gateway.deployment.url_path_map}"
}