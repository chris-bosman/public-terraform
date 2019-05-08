terraform {
  backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
  name    = "${var.resource_group_name}"
}

data "azurerm_resource_group" "kv" {
  name    = "${var.vault_resource_group_name}"
}

data "azurerm_key_vault" "deployment" {
  name                = "${var.key_vault_name}"
  resource_group_name = "${data.azurerm_resource_group.kv.name}"
}

data "azurerm_key_vault_secret" "deployment" {
  name      = "${var.aks_deployment_secret_name}"
  vault_uri = "${data.azurerm_key_vault.deployment.vault_uri}"
}

data "azurerm_azuread_service_principal" "deployment" {
  display_name = "${var.k8s_service_principal_name}"
}

resource "random_string" "aks_id" {
  length      = 6
  special     = false
  upper       = false
  min_lower   = 1
  min_numeric = 1
}

resource "azurerm_kubernetes_cluster" "deployment" {
  name                = "${var.aks_name}"
  location            = "${data.azurerm_resource_group.deployment.location}"
  resource_group_name = "${data.azurerm_resource_group.deployment.name}"
  dns_prefix          = "${substr(var.aks_name, 0, 10)}-${data.azurerm_resource_group.deployment.name}-${random_string.aks_id.result}"

  agent_pool_profile {
    name            = "nodepool1"
    count           = "${var.aks_node_count}"
    vm_size         = "${var.aks_node_size}"
    os_disk_size_gb = 30
    max_pods        = 110
  }

  service_principal {
    client_id       = "${azurerm_azuread_service_principal.deployment.id}"
    client_secret   = "${data.azurerm_key_vault_secret.deployment.value}"
  }

  tags {
    environment       = "${var.environment}"
    department        = "${var.department}"
    service           = "Compute"
    component         = "Kubernetes Cluster"
    cluster_function  = "${var.function_name}"  
  }
}