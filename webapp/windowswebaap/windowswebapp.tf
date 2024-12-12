resource "azurerm_windows_web_app" "webapp" {

  lifecycle {
    ignore_changes = [
      app_settings,
      site_config["virtual_application"],
      site_config["ip_restriction"]
      ]
  }
  name                    = var.webapp_name
  resource_group_name     = var.webapp_resource_group_name
  location                = var.webapp_location
  service_plan_id         = var.webapp_plan_id
  app_settings            = merge(
    var.webapp_appsettings,
    {
      APPINSIGHTS_INSTRUMENTATIONKEY = var.webapp_site_config_application_insights_key
    },
    {
      APPINSIGHTS_CONNECTION_STRING = var.webapp_site_config_application_insights_connection_string
    }
  )
  client_affinity_enabled = var.webapp_client_affinity_enabled
  https_only              = var.webapp_https_only
  tags                    = var.webapp_tags

  auth_settings {
    additional_login_parameters    = {}
    allowed_external_redirect_urls = []
    enabled                        = var.webapp_auth_settings_enabled
    token_refresh_extension_hours  = var.webapp_auth_settings_token_refresh_extension_hours
    token_store_enabled            = var.webapp_authsettings_token_store_enabled
  }
  identity {
    identity_ids = []
    type         = var.webapp_identity_type
  }
  logs {
    detailed_error_messages = var.webapp_logs_detailed_error_messages
    failed_request_tracing  = var.webapp_logs_failed_request_tracing
    http_logs {
      file_system {
        retention_in_days = var.webapp_logs_http_logs_file_system_retention_in_days
        retention_in_mb   = var.webapp_logs_http_logs_file_system_retention_in_mb
      }
    }
  }
  site_config {
    always_on  = true
    ftps_state = "FtpsOnly"
    # default_documents = var.webapp_site_config_default_documents
    scm_minimum_tls_version = var.webapp_site_config_scm_minimum_tls_version
    vnet_route_all_enabled  = var.webapp_site_config_vnet_route_all_enabled
    application_stack {
      current_stack  = var.webapp_site_config_current_stack  #"dotnet"
      dotnet_version = var.webapp_site_config_dotnet_version #"v6.0"
    }

    cors {
      allowed_origins     = var.webapp_site_config_cors_allowed_origins
      support_credentials = var.webapp_site_config_cors_support_credentials
    }

    #virtual_application {
    # physical_path = var.webapp_site_config_virtual_application_physical_path
    # preload       = var.webapp_site_config_virtual_application_preload
    # virtual_path  = var.webapp_site_config_virtual_application_virtual_path
    # }
    #dynamic "virtual_application" {
    # for_each = var.virtual_application
    # content {
    # physical_path = virtual_application.value.physical_path
    # preload       = virtual_application.value.preload
    # virtual_path  = virtual_application.value.virtual_path
    #}
    #}

    # virtual_application {
    #   physical_path = var.webapp_site_config_virtual_application_physical_path_2
    #   preload       = var.webapp_site_config_virtual_application_preload_2
    #   virtual_path  = var.webapp_site_config_virtual_application_virtual_path_2
    # }
    dynamic "ip_restriction" {
      for_each = var.allowed_networks
      content {
        action = ip_restriction.value.action

        ip_address = ip_restriction.value.ip_address
        name       = ip_restriction.value.name
        priority   = ip_restriction.value.priority

        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
      }
    }
  }
}

resource "azurerm_windows_web_app_slot" "slot" {
  lifecycle {
    ignore_changes = [
      app_settings,
      site_config["virtual_application"],
    site_config["ip_restriction"]]
  }
  for_each       = toset(var.app_slots)
  name           = each.key
  app_service_id = azurerm_windows_web_app.webapp.id
  #service_plan_id         = var.webapp_plan_id


  app_settings            = merge(
  var.webapp_appsettings, 
  {
    APPINSIGHTS_INSTRUMENTATIONKEY = var.applicationinsights_slot_application_insights_key[each.key]
  },
  {
    APPINSIGHTS_CONNECTION_STRING = var.applicationinsights_slot_application_insights_connection_string[each.key]
  }
  )
  client_affinity_enabled = var.webapp_client_affinity_enabled
  https_only              = var.webapp_https_only
  tags                    = var.webapp_tags

  auth_settings {
    additional_login_parameters    = {}
    allowed_external_redirect_urls = []
    enabled                        = var.webapp_auth_settings_enabled
    token_refresh_extension_hours  = var.webapp_auth_settings_token_refresh_extension_hours
    token_store_enabled            = var.webapp_authsettings_token_store_enabled
  }
  identity {
    identity_ids = []
    type         = var.webapp_identity_type
  }
  logs {
    detailed_error_messages = var.webapp_logs_detailed_error_messages
    failed_request_tracing  = var.webapp_logs_failed_request_tracing
    http_logs {
      file_system {
        retention_in_days = var.webapp_logs_http_logs_file_system_retention_in_days
        retention_in_mb   = var.webapp_logs_http_logs_file_system_retention_in_mb
      }
    }
  }
  site_config {
    always_on  = true
    use_32_bit_worker = var.use_32_bit_worker
    ftps_state = "FtpsOnly"
    # default_documents = var.webapp_site_config_default_documents
    scm_minimum_tls_version = var.webapp_site_config_scm_minimum_tls_version
    vnet_route_all_enabled  = var.webapp_site_config_vnet_route_all_enabled
    application_stack {
      current_stack  = var.webapp_site_config_current_stack  #"dotnet"
      dotnet_version = var.webapp_site_config_dotnet_version #"v6.0"
    }

    cors {
      allowed_origins = [
        for item in var.webapp_site_config_cors_allowed_origins :
        replace(item, var.cors_origin_dev_env_value, each.key)
      ]
      support_credentials = var.webapp_site_config_cors_support_credentials
    }

    #    virtual_application {
    #       physical_path = var.webapp_site_config_virtual_application_physical_path
    #      preload       = var.webapp_site_config_virtual_application_preload
    #      virtual_path  = var.webapp_site_config_virtual_application_virtual_path
    #   }

    #dynamic "virtual_application" {
    #  for_each = var.virtual_application
    #  content {
    #    physical_path = virtual_application.value.physical_path
    #    preload       = virtual_application.value.preload
    #    virtual_path  = virtual_application.value.virtual_path
    #  }
    #}

    # virtual_application {
    #   physical_path = var.webapp_site_config_virtual_application_physical_path_2
    #   preload       = var.webapp_site_config_virtual_application_preload_2
    #   virtual_path  = var.webapp_site_config_virtual_application_virtual_path_2
    # }
    dynamic "ip_restriction" {
      for_each = var.allowed_networks
      content {
        action = ip_restriction.value.action

        ip_address = ip_restriction.value.ip_address
        name       = ip_restriction.value.name
        priority   = ip_restriction.value.priority

        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
      }
    }
  }
}