resource "azurerm_application_gateway" "application_gateway" {
  name                = var.application_gateway_name
  resource_group_name = var.application_gateway_resource_group_name
  location            = var.application_gateway_location

  sku {
    name     = var.application_gateway_sku_name
    tier     = var.application_gateway_sku_tier
    capacity = var.application_gateway_sku_capacity
  }

  gateway_ip_configuration {
    name      = var.application_gateway_ip_configuration_name
    subnet_id = var.application_gateway_subnet_id
  }

  frontend_port {
    name = var.application_gateway_frontend_port_name
    port = var.application_gateway_frontend_port
  }

  frontend_ip_configuration {
    name                 = var.application_gateway_frontend_ip_configuration_name
    public_ip_address_id = var.application_gateway_public_ip_id
  }

  backend_address_pool {
    name = var.application_gateway_backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.application_gateway_backend_http_settings_name
    cookie_based_affinity = "Disabled"
    port                  = var.application_gateway_backend_port
    protocol              = "Https"
    request_timeout       = 20
  }

  http_listener {
    name                           = var.application_gateway_http_listener_name
    frontend_ip_configuration_name = var.application_gateway_frontend_ip_configuration_name
    frontend_port_name             = var.application_gateway_frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = "test"
  }

  request_routing_rule {
    name                       = var.application_gateway_request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.application_gateway_http_listener_name
    priority                   = var.request_routing_rule_priority
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.backend_http_settings_name
  }

  dynamic "rewrite_rule_set" {
    for_each = var.application_gateway_rewrite_rule_set
    content {
      name = rewrite_rule_set.value
    }
  }

  dynamic "probe" {
    for_each = var.application_gateway_probes
    content {
      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      path                                      = probe.value.path
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = true
    }

  }

  firewall_policy_id = var.web_application_firewall_id
  tags               = var.application_gateway_tags
}