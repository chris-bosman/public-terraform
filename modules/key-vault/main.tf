terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
    name = "${var.resource_group_name}"
}

resource "azurerm_key_vault" "deployment" {
    name                = "${var.key_vault_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
    location            = "${data.azurerm_resource_group.deployment.location}"
    tenant_id           = "${var.tenant_id}"

    sku {
        name = "${var.key_vault_sku}"
    }

    tags {
        environment = "${var.environment}"
        department  = "${var.department}"
        service     = "Security"
        component   = "Key Vault"
    }
}