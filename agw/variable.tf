variable "application_gateway_name" {
    description = "The name of the application gateway"
    type = string  
}
variable "application_gateway_resource_group_name" {
    description = "The name of the resource group in which the application gateway will be created"
    type = string
}
variable "application_gateway_location" {
    description = "The location in which the application gateway will be created"
    type = string
}
variable "application_gateway_sku_name" {
    description = "The name of the SKU for the application gateway"
    type = string
}
variable "application_gateway_sku_tier" {
    description = "The tier of the SKU for the application gateway"
    type = string
}
variable "application_gateway_sku_capacity" {
    description = "The capacity of the SKU for the application gateway"
    type = number
}
variable "application_gateway_public_ip_id" {
    description = "The ID of the public IP address to associate with the application gateway"
    type = string
}
variable "application_gateway_frontend_port" {
    description = "The frontend port for the application gateway"
    type = number
}
variable "application_gateway_backend_port" {
    description = "The backend port for the application gateway"
    type = number
}
# variable "application_gateway_ssl_certificate_data" {
#     description = "The data of the SSL certificate to use for the application gateway"
#     type = string
# }
# variable "application_gateway_ssl_certificate_password" {
#     description = "The password for the SSL certificate"
#     type = string
# }
variable "application_gateway_tags" {
    description = "A map of tags to apply to the application gateway"
    type = map(string)
}
variable "frontend_ip_configuration_name" {
    description = "The name of the frontend IP configuration for the application gateway"
    type = string
}
variable "frontend_port_name" {
    description = "The name of the frontend port for the application gateway"
    type = string
}
variable "application_gateway_subnet_id" {
    description = "The ID of the subnet in which the application gateway will be created"
    type = string
}
variable "request_routing_rule_priority" {
    description = "The priority of the request routing rule for the application gateway"
    type = number
}
variable "backend_address_pool_name" {
    description = "The name of the backend address pool for the application gateway"
    type = string
}
variable "backend_http_settings_name" {
    description = "The name of the backend HTTP settings for the application gateway"
    type = string
}
variable "web_application_firewall_id" {
    description = "The ID of the WAF policy to associate with the application gateway"
    type = string  
}
variable "application_gateway_rewrite_rule_set" {
  description = "List of rewrite rule sets to configure"
  type        = list(string)
  default     = []
}

variable "application_gateway_probes" {
  description = "List of probes to configure"
  type        = list(object({
    name                 = string
    protocol             = string
    path                 = string
    interval             = number
    timeout              = number
    unhealthy_threshold  = number
  }))
  default = []
}
variable "application_gateway_frontend_port_name" {
  description = "The name of the frontend port for the application gateway"
  type = string
}
variable "application_gateway_ip_configuration_name" {
  description = "The name of the frontend IP configuration for the application gateway"
  type = string
  
}
variable "application_gateway_frontend_ip_configuration_name" {
  description = "The name of the frontend IP configuration for the application gateway"
    type = string
}
variable "application_gateway_backend_address_pool_name" {
  description = "The name of the backend address pool for the application gateway"
    type = string
}

variable "application_gateway_backend_http_settings_name" {
  description = "The name of the backend HTTP settings for the application gateway"
    type = string
}
variable "application_gateway_http_listener_name" {
  description = "The name of the HTTP listener for the application gateway"
    type = string
}
variable "application_gateway_request_routing_rule_name" {
  description = "The name of the request routing rule for the application gateway"
    type = string
}