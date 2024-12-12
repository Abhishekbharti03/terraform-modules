variable "webapp_name" {
  type=string
  description = "webapp name"
}
variable "webapp_resource_group_name" {
  type=string
  description = "webapp resource group name"
}
variable "webapp_location" {
  type=string
  description = "webapp location"
}
variable "webapp_plan_id" {
  type=string
  description = "webapp plan id"
}
variable "webapp_appsettings" {
  type=map(string)
  description = "webapp appsettings"
}
variable "webapp_client_affinity_enabled" {
  type = bool
  description = "webapp client affinity enabled"
}
variable "webapp_https_only" {
  type = bool
  description = "webapp https only"
}
variable "webapp_tags" {
  type = map(string)
  description = "webapp tags"
}

variable "webapp_auth_settings_enabled" {
  type = bool
  description = "Should the Authentication / Authorization feature is enabled for the Windows Web App be enabled?"
}
variable "webapp_auth_settings_token_refresh_extension_hours" {
  type = number
  description = "The number of hours after session token expiration that a session token can be used to call the token refresh API"
}

variable "webapp_authsettings_token_store_enabled" {
 type = bool
 
 description = "Should the Windows Web App durably store platform-specific security tokens that are obtained during login flows?"
}

variable "webapp_identity_type" {
  type = string
  description = "webapp identity type"
}

variable "webapp_logs_detailed_error_messages" {
  type = bool
  
  description = "webapp_logs_detailed_error_messages"
}
variable "webapp_logs_failed_request_tracing" {
  type = bool
  
  description = "webapp logs failed request tracing"
}
variable "webapp_logs_http_logs_file_system_retention_in_days" {
  type = number
 
  description = "webapp logs http logs file system retention in days"
}
variable "webapp_logs_http_logs_file_system_retention_in_mb" {
  type = number
  
  description = "webapp logs http logs file system retention in mb"
}

variable "webapp_site_config_always_on" {
  type = bool
  description = "webapp site config always_on"
}
# variable "webapp_site_config_default_documents" {
#   type = list(string)
#    description = "webapp site config default documents"
# }

# variable "webapp_site_config_health_check_eviction_time_in_minutes" {
#   type = number
#     description = "webapp site config health check eviction time in minutes"
# }
variable "webapp_site_config_scm_minimum_tls_version" {
  type = string
  description = "webapp site config scm minimum tls version"
}
variable "webapp_site_config_vnet_route_all_enabled" {
  type = bool
  description = "webapp site config vnet_route_all_enabled"
}

variable "webapp_site_config_cors_allowed_origins" {
  type = list(string)
  
  description = "webapp site config cors allowed origins"
  default = []
}
variable "webapp_site_config_cors_support_credentials" {
  type = bool  
  description = "webapp site config cors support credentials"
  default = false
}

#variable "webapp_site_config_virtual_application_physical_path" {
 #  type = string
  # description = "webapp site config virtual application physical path"
 #}
 #variable "webapp_site_config_virtual_application_preload" {
  # type = bool
  
   #description = "webapp site config virtual application preload"
 #}
 #variable "webapp_site_config_virtual_application_virtual_path" {
  # type = string
   #description = "webapp site config virtual application virtual path"
 #}

# variable "webapp_site_config_virtual_application_physical_path_2" {
#   type = string
#   description = "webapp site config virtual application physical path"
# }
# variable "webapp_site_config_virtual_application_preload_2" {
#   type = bool
  
#   description = "webapp site config virtual application preload"
# }
# variable "webapp_site_config_virtual_application_virtual_path_2" {
#   type = string
#   description = "webapp site config virtual application virtual path"
# }

# variable "allowed_networks" {
#   type = list(map(string))
# }

# variable "webapp_site_config_ip_restriction1_priority" {
#   type = number
#   description = "webapp site config ip restriction 1 priority"
# }
# variable "webapp_site_config_ip_restriction1_virtual_network_subnet_id" {
#   type = string
#   description = "webapp site config ip restriction virtual network subnet_id"
# }
# variable "webapp_site_config_ip_restriction2_priority" {
#   type = number
#   description = "webapp site config ip restriction 2 priority"
# }
# variable "webapp_site_config_ip_restriction2_ip_address" {
#   type = string
#   description = "webapp site config ip restriction ip_address"
# }
variable "allowed_networks" {
  type=list(object({
action                    = string
# headers                   = list(string)
ip_address                = string #"51.11.0.0/16"
name                      = string #"Azure IPs (temp)"
priority                  = number
# service_tag               = string
virtual_network_subnet_id = string
  
}))
description = "allowed network"
}



variable "webapp_site_config_current_stack" {
  type = string
  description = "webapp_site_config_current_stack"
}

variable "webapp_site_config_dotnet_version" {
  type = string
  description = "webapp_site_config_dotnet_version"
}
variable "virtual_application" {
  type=list(object({


physical_path             = string #"Azure IPs (temp)"
preload                   = bool
virtual_path              = string
  
}))
description = "virtual_application"
}

variable app_slots {
  type = list(string)
  description = "slots"
  default = ["qa","iat"]
}

variable "cors_origin_dev_env_value" {
  type = string
  description = "cors_origin_dev_env_value"
  default = "dev"
}
