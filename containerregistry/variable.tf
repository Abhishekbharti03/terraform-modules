# # Resource Group Variables
# #-------------------------------------------------------------
# # CRBCFT-CLIENTPORTAL-EM22-DR-RGRP variables starting from here
variable "containerregistry_name" {
  type        = string
  description = ".containerregistry_name"
}
variable "containerregistry_rg" {
  type        = string
  description = "containerregistry_rg"
}
variable "containerregistry_location" {
  type        = string
  description = "containerregistry_location"
}
variable "containerregistry_sku" {
  type        = string
  description = "containerregistry_sku"
}
variable "containerregistry_admin_enabled" {
  type        = bool
  description = "containerregistry_admin_enabled"
  default     = true
}
# variable "containerregistry_admin_username" {
#   type        = string
#   description = "containerregistry_admin_username"
# }
variable "containerregistry_anonymous_pull_enabled" {
  type        = bool
  description = "containerregistry_anonymous_pull_enabled"
  default     = false
}
variable "containerregistry_data_endpoint_enabled" {
  type        = bool
  description = "containerregistry_data_endpoint_enabled"
  default     = false
}
# variable "containerregistry_login_server" {
#   type        = string
#   description = "containerregistry_login_server"
# }
variable "containerregistry_quarantine_policy_enabled" {
  type        = bool
  description = "containerregistry_quarantine_policy_enabled"
  default     = false
}
variable "network_rule_set" {
  type = list(object({
    default_action = string

  }))
  description = "network_rule_set"
  default = [{ 
  default_action = "Deny" }]
}
variable "allowed_ip_address" {
  type        = string
  description = "allowed_ip_address"
  default =  "158.82.1.0/24" 
}
#variable "retention_policy" {
#  type=list(object({
#days              = number
#enabled         = bool 
#}))
#description = "retention_policy"
#}
#variable "trust_policy" {
#  type=list(object({
#enabled         = bool 
#}))
#description = "trust_policy"
#}
variable "containerregistry_tags" {
  type        = map(string)
  description = "containerregistry_tags"
}