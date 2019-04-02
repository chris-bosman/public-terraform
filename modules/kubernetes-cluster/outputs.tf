output "id" {
    value = "${azurerm_kubernetes_cluster.deployment.id}"
}

output "fqdn" {
  value = "${azurerm_kubernetes_cluster.deployment.fqdn}"
}

output "node_resource_group" {
  value = "${azurerm_kubernetes_cluster.deployment.node_resource_group}"
}

output "kube_config_raw" {
    value = "${azurerm_kubernetes_cluster.deployment.kube_config_raw}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.deployment.kube_config.0.client_key}"
}

output "client_certificate" {
    value = "${azurerm_kubernetes_cluster.deployment.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.deployment.kube_config.0.cluster_ca_certificate}"
}

output "host" {
    value = "${azurerm_kubernetes_cluster.deployment.kube_config.0.host}"
}

output "username" {
  value = "${azurerm_kubernetes_cluster.deployment.kube_config.0.username}"
}

output "password" {
    value = "${azurerm_kubernetes_cluster.deployment.kube_config.0.password}"
}


