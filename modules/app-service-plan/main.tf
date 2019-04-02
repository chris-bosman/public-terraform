terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "deployment" {
    name    = "${var.resource_group_name}"
}

resource "azurerm_app_service_plan" "deployment" {
    name                = "${var.service_plan_name}"
    location            = "${data.azurerm_resource_group.deployment.location}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
    kind                = "app"

    sku {
        tier = "${var.sku_tier}"
        size = "${var.sku_size}"
    }

    tags {
        environment     = "${var.environment}"
        department      = "${var.department}"
        service         = "App Service"
        component       = "App Service Plan"
        app_function    = "${var.function_name}"
    }
}