terraform {
    backend "azurerm" {}
}

locals {
    connection_string_count = "${var.connection_string_count}"
}

data "azurerm_resource_group" "deployment" {
    name    = "${var.resource_group_name}"
}
data "azurerm_app_service_plan" "deployment" {
    name                = "${var.service_plan_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

resource "azurerm_app_service" "deployment" { 
    name                    = "${var.app_service_name}"
    location                = "${data.azurerm_app_service_plan.deployment.location}"
    resource_group_name     = "${data.azurerm_resource_group.deployment.name}"
    app_service_plan_id     = "${data.azurerm_app_service_plan.deployment.id}"
    client_affinity_enabled = true
    enabled                 = true
    https_only              = "${var.https_only}"
    
    app_settings = "${merge(var.app_service_settings,map("SLOT_NAME", "production"))}"

    tags {
        environment     = "${var.environment}"
        department      = "${var.department}"
        parent_resource = "${data.azurerm_app_service_plan.deployment.name}"
        service         = "App Service"
        component       = "Web App"
        app_function    = "${var.function_name}"
        slot            = "Self"
    }
}

resource "azurerm_app_service_slot" "staging" { 
    count                   = "${var.enable_staging == "true" ? 1 : 0}"
    name                    = "staging"
    app_service_name        = "${azurerm_app_service.deployment.name}"
    location                = "${data.azurerm_app_service_plan.deployment.location}"
    resource_group_name     = "${data.azurerm_resource_group.deployment.name}"
    app_service_plan_id     = "${data.azurerm_app_service_plan.deployment.id}"
    client_affinity_enabled = true
    enabled                 = true
    https_only              = "${var.https_only}"
    
    app_settings = "${merge(var.app_service_settings,map("SLOT_NAME", "staging"))}"

    tags {
        environment     = "${var.environment}"
        service         = "App Service"
        component       = "Web App"
        subcomponent    = "Slot"
        app_function    = "${var.function_name}"
        slot            = "Blue"
        parent_resource = "${azurerm_app_service.deployment.name}"
    }
}

resource "azurerm_app_service_slot" "blue" { 
    count                   = "${var.enable_blue_green == "true" ? 1 : 0}"
    name                    = "blue"
    app_service_name        = "${azurerm_app_service.deployment.name}"
    location                = "${data.azurerm_app_service_plan.deployment.location}"
    resource_group_name     = "${data.azurerm_resource_group.deployment.name}"
    app_service_plan_id     = "${data.azurerm_app_service_plan.deployment.id}"
    client_affinity_enabled = true
    enabled                 = true
    https_only              = "${var.https_only}"
    
    app_settings = "${merge(var.app_service_settings,map("SLOT_NAME", "blue"))}"

    tags {
        environment     = "${var.environment}"
        service         = "App Service"
        component       = "Web App"
        subcomponent    = "Slot"
        app_function    = "${var.function_name}"
        slot            = "Blue"
        parent_resource = "${azurerm_app_service.deployment.name}"
    }
}

resource "azurerm_app_service_slot" "green" { 
    count                   = "${var.enable_blue_green == "true" ? 1 : 0}"
    name                    = "green"
    app_service_name        = "${azurerm_app_service.deployment.name}"
    location                = "${data.azurerm_app_service_plan.deployment.location}"
    resource_group_name     = "${data.azurerm_resource_group.deployment.name}"
    app_service_plan_id     = "${data.azurerm_app_service_plan.deployment.id}"
    client_affinity_enabled = true
    enabled                 = true
    https_only              = "${var.https_only}"
    
    app_settings = "${merge(var.app_service_settings,map("SLOT_NAME", "green"))}"

    tags {
        environment     = "${var.environment}"
        service         = "App Service"
        component       = "Web App"
        subcomponent    = "Slot"
        slot            = "Green"
        app_function    = "${var.function_name}"
        parent_resource = "${azurerm_app_service.deployment.name}"
    }
}