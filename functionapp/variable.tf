#Application insights variables


variable "application_insights_type" {
  type        = string
  description = "resource group name"
}
variable "application_insights_location" {
  type        = string
  description = "resource group location"
}
variable "application_insights_name" {
  type        = string
  description = "resource group location"
}
variable "application_insights_resource_group_name" {
  type        = string
  description = "resource group location"
}
variable "application_insights_sampling_percentage" {
  type        = number
  description = "resource group location"
}
variable "application_insights_tags" {
  type        = map(string)
  description = "application_insights_tags"
}

variable "application_insights_workspace_id" {
  type        = string
  description = "application_insights_workspace_id"
}



variable "functionapp_name" {
  type        = string
  description = "function app name"
}
variable "functionapp_resource_group_name" {
  type        = string
  description = "function app resource group name"
}
variable "functionapp_location" {
  type        = string
  description = "function app location"
}
variable "functionapp_storage_account_name" {
  type        = string
  description = "function app storage account name"
}
variable "functionapp_storage_account_access_key" {
  type        = string
  description = "function app storage account access key"
}
variable "functionapp_service_plan_id" {
  type        = string
  description = "function app service plan id"
}
variable "functionapp_https_only" {
  type        = bool
  description = "function app https only"
}
#variable "functionapp_app_settings" {
#  type=map(string)
#  description = "function app app settings"
#}
variable "functionapp_client_certificate_mode" {
  type        = string
  description = "function app client certificate mode"
}
variable "functionapp_tags" {
  type        = map(string)
  description = "function app tags"
}
variable "functionapp_identity_type" {
  type        = string
  description = "function app identity type"
}
variable "functionapp_site_config_application_insights_connection_string" {
  type        = string
  description = "function app site config application insights connection string"
}
variable "functionapp_site_config_application_insights_key" {
  type        = string
  description = "function app site config application insights key"
}

variable "functionapp_site_config_scm_minimum_tls_version" {
  type        = string
  description = "function app site config scm minimum tls version"
}
# variable "functionapp_site_config_scm_type" {
#   type=string
#   description = "functionapp_site_config_scm_typ"
# }
variable "functionapp_site_config_vnet_route_all_enabled" {
  type        = bool
  description = "function app site config scm minimum tls version"
}
variable "functionapp_site_config_always_on" {
  type        = string
  description = "function app site config ip restrictions priority"
}

variable "functionapp_site_config_websockets_enabled" {
  type        = bool
  description = "functionapp site config websockets enabled"
  default     = false
}
# variable "functionapp_site_config_cors_allowed_origins" {
#   type        = list(string)
#   description = "functionapp site config cors allowed origins"
#   default = []
# }
# variable "functionapp_site_config_cors_support_credentials" {
#   type        = bool
#   description = "functionapp site config cors support credentials"
#   default = false
# }


variable "ipres" {
  type = list(object({
    priority                  = number
    ip_address                = string
    name                      = string
    action                    = string
    virtual_network_subnet_id = string



  }))
  description = "ip restriction"
}

variable "app_slots" {
  type        = list(string)
  description = "slots"
  default     = []
}

variable "Env_Name_Short" {
  type        = string
  description = "Env_Name_Short"
  #default = "-C-"
}
variable "applicationinsights_slot_application_insights_connection_string" {
  type        = map(string)
  description = "applicationinsights_slot_application_insights_connection_string"
}
variable "applicationinsights_slot_application_insights_key" {
  type        = map(string)
  description = "applicationinsights_slot_application_insights_key"
}