resource "azurerm_windows_function_app" "functionapp" {
  lifecycle {
    ignore_changes = [
      app_settings,
      site_config["virtual_application"],
      site_config["ip_restriction"]
    ]
  }

  name                       = var.functionapp_name
  resource_group_name        = var.functionapp_resource_group_name
  location                   = var.functionapp_location
  storage_account_name       = var.functionapp_storage_account_name
  storage_account_access_key = var.functionapp_storage_account_access_key
  service_plan_id            = var.functionapp_service_plan_id
  https_only                 = var.functionapp_https_only
  #app_settings               = var.functionapp_app_settings
  client_certificate_mode = var.functionapp_client_certificate_mode
  tags                    = var.functionapp_tags
  identity {
    identity_ids = []
    type         = var.functionapp_identity_type
  }
  site_config {
    application_insights_connection_string = var.functionapp_site_config_application_insights_connection_string
    application_insights_key               = var.functionapp_site_config_application_insights_key
    ftps_state                             = "FtpsOnly"
    scm_minimum_tls_version                = var.functionapp_site_config_scm_minimum_tls_version
    vnet_route_all_enabled                 = var.functionapp_site_config_vnet_route_all_enabled
    always_on                              = true
    websockets_enabled                     = var.functionapp_site_config_websockets_enabled
    # cors {
    #   allowed_origins     = var.functionapp_site_config_cors_allowed_origins
    #   support_credentials = var.functionapp_site_config_cors_support_credentials
    # }
    dynamic "ip_restriction" {
      for_each = var.ipres
      content {
        priority                  = lookup(ip_restriction.value, "priority", null)
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        name                      = lookup(ip_restriction.value, "name", null)
        action                    = lookup(ip_restriction.value, "action", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)




      }

    }
    # ip_restriction = null

  }
}

resource "azurerm_windows_function_app_slot" "funntionapp_slot" {
  lifecycle {
    ignore_changes = [
      app_settings,
      site_config["virtual_application"],
      site_config["ip_restriction"]
    ]
  }
  for_each                   = toset(var.app_slots)
  name                       = each.key
  function_app_id            = azurerm_windows_function_app.functionapp.id
  storage_account_name       = var.functionapp_storage_account_name
  storage_account_access_key = var.functionapp_storage_account_access_key
  #service_plan_id            = var.functionapp_service_plan_id

  https_only                 = var.functionapp_https_only
  #app_settings            = var.functionapp_app_settings
  client_certificate_mode = var.functionapp_client_certificate_mode
  tags                    = var.functionapp_tags
  identity {
    identity_ids = []
    type         = var.functionapp_identity_type
  }
  site_config {
    application_insights_connection_string = var.applicationinsights_slot_application_insights_connection_string[each.key]
    application_insights_key               = var.applicationinsights_slot_application_insights_key[each.key]
    ftps_state                             = "FtpsOnly"
    scm_minimum_tls_version                = var.functionapp_site_config_scm_minimum_tls_version
    vnet_route_all_enabled                 = var.functionapp_site_config_vnet_route_all_enabled
    always_on                              = true
    websockets_enabled                     = var.functionapp_site_config_websockets_enabled
    # cors {
    #   allowed_origins     = var.functionapp_site_config_cors_allowed_origins
    #   support_credentials = var.functionapp_site_config_cors_support_credentials
    # }
    dynamic "ip_restriction" {
      for_each = var.ipres
      content {
        priority                  = lookup(ip_restriction.value, "priority", null)
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        name                      = lookup(ip_restriction.value, "name", null)
        action                    = lookup(ip_restriction.value, "action", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)

      }

    }
    # ip_restriction = null

  }
}

