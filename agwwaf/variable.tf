variable "web_application_firewall_name" {
    description = "The name of the web application firewall policy"
    type = string  
}
variable "web_application_firewall_resource_group_name" {
    description = "The name of the resource group in which the web application firewall policy will be created"
    type = string
}
variable "web_application_firewall_location" {
    description = "The location in which the web application firewall policy will be created"
    type = string
}
variable "web_application_firewall_tags" {
    description = "A map of tags to apply to the web application firewall policy"
    type = map(string)
}
variable "request_body_check" {
    description = "Whether to check the request body"
    type = bool
}
variable "file_upload_limit_in_mb" {
    description = "The file upload limit in MB"
    type = number
}
variable "max_request_body_size_in_kb" {
    description = "The maximum request body size in KB"
    type = number
}
variable "custom_rules" {
  description = "List of custom rules for the WAF policy"
  type = list(object({
    name               = string
    priority           = number
    rule_type          = string
    action             = string
    match_conditions = list(object({
      variable_name      = string
      operator           = string
      negation_condition = bool
      match_values       = list(string)
    }))
  }))
}

variable "exclusions" {
  type = list(object({
    match_variable          = string
    selector                = string
    selector_match_operator = string
  }))
}