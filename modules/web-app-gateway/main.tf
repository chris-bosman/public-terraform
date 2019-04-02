terraform {
    backend "azurerm" {}
}
data "azurerm_resource_group" "deployment" {
    name    = "${var.resource_group_name}"
}
data "azurerm_virtual_network" "deployment" {
    name                = "${var.virtual_network_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}
data "azurerm_subnet" "frontend" {
    name                    = "${var.frontend_subnet_name}"
    resource_group_name     = "${data.azurerm_resource_group.deployment.name}"
    virtual_network_name    = "${data.azurerm_virtual_network.deployment.name}"
}
data "azurerm_subnet" "backend" {
    name                    = "${var.backend_subnet_name}"
    resource_group_name     = "${data.azurerm_resource_group.deployment.name}"
    virtual_network_name    = "${data.azurerm_virtual_network.deployment.name}"
}
data "azurerm_public_ip" "deployment" {
    name                    = "${var.public_ip_name}"
    resource_group_name     = "${data.azurerm_resource_group.deployment.name}"
}

locals {
    backend_address_pool_name_classic   = "${data.azurerm_virtual_network.deployment.name}-classic-beap"
    backend_address_pool_name_api       = "${data.azurerm_virtual_network.deployment.name}-api-beap"    
    frontend_port_name                  = "${data.azurerm_virtual_network.deployment.name}-feport"
    frontend_ip_configuration_name      = "${data.azurerm_virtual_network.deployment.name}-feip"
    http_setting_name_classic           = "${data.azurerm_virtual_network.deployment.name}-classic-behtst"
    http_setting_name_api               = "${data.azurerm_virtual_network.deployment.name}-api-behtst"
    listener_name                       = "${data.azurerm_virtual_network.deployment.name}-httplstn"
    request_routing_rule_name           = "${data.azurerm_virtual_network.deployment.name}-rqrt"
}

resource "azurerm_application_gateway" "deployment" {
    name                = "${var.gateway_name}"
    resource_group_name = "${data.azurerm_resource_group.deployment.name}"
    location            = "${data.azurerm_resource_group.deployment.location}"

    sku {
        name        = "${var.gateway_sku_name}"
        tier        = "${var.gateway_sku_tier}"
        capacity    = "${var.gateway_sku_capacity}"
    }

    gateway_ip_configuration {
        name        = "${var.gateway_name}-ipconf"
        subnet_id   = "${data.azurerm_subnet.frontend.id}"
    }

    authentication_certificate {
        name        = "${var.certificate_name}"
        data        = ""
    }

    frontend_port {
        name    = "${local.frontend_port_name}"
        port    = "${var.frontend_port}"
    }

    frontend_ip_configuration {
        name                            = "${local.frontend_ip_configuration_name}"
        public_ip_address_id            = "${data.azurerm_public_ip.deployment.id}"
        private_ip_address_allocation   = "Dynamic"
    }

    backend_address_pool {
        name        = "${local.backend_address_pool_name_classic}"
        fqdn_list   = "[${var.classic_url}]"
    }

    backend_address_pool {
        name        = "${local.backend_address_pool_name_api}"
        fqdn_list   = "[${var.api_url}]"
    }

    backend_http_settings {
        name                    = "${local.http_setting_name_classic}"
        cookie_based_affinity   = "${var.cookie_affinity}"
        port                    = "${var.backend_port}"
        probe_name              = "${var.gateway_name}-classic-probe"
        protocol                = "${var.backend_protocol}"
        request_timeout         = "${var.request_timeout_classic}"
    }

    backend_http_settings {
        name                    = "${local.http_setting_name_api}"
        cookie_based_affinity   = "${var.cookie_affinity}"
        port                    = "${var.backend_port}"
        probe_name              = "${var.gateway_name}-api-probe"
        protocol                = "${var.backend_protocol}"
        request_timeout         = "${var.request_timeout_api}"
    }

    http_listener {
        name                            = "${local.listener_name}"
        frontend_ip_configuration_name  = "${local.frontend_ip_configuration_name}"
        frontend_port_name              = "${local.frontend_port_name}"
        protocol                        = "${var.frontend_protocol}"
        ssl_certificate_name            = "${var.certificate_name}"
    }

    request_routing_rule {
        name                        = "${local.request_routing_rule_name}"
        rule_type                   = "${var.routing_rule_type}"
        http_listener_name          = "${local.listener_name}"
        backend_address_pool_name   = "${local.backend_address_pool_name}"
        backend_http_settings_name  = "${local.http_setting_name}"
    }

    probe {
        name                = "${var.gateway_name}-classic-probe"
        probe               = "${var.probe_protocol}"
        host                = "${var.probe_host}"
        interval            = "${var.probe_interval}"
        path                = "${var.probe_path}"
        timeout             = "${var.probe_timeout}"
        unhealthy_threshold = "${var.probe_unhealthy_threshold}"

        match {
            status_code = ["200-399"]
        }
    }
}