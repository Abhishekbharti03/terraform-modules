variable "eventhub_namespace_name" {
    type = string
    description = "eventhub namespace name"
}
variable "eventhub_namespace_resource_group_name" {
    type = string
    description = "eventhub namespace resource group name"
}
variable "eventhub_namespace_location" {
    type = string
    description = "eventhub_namespace location"
}
variable "eventhub_namespace_sku" {
    type = string
    description = "eventhub_namespace sku"  
}
variable "eventhub_namespace_capacity" {
    type = string
    description = "eventhub_namespace capacity"
}
variable "eventhub_namespace_local_authentication_enabled" {
    type = string
    description = "eventhub_namespace authencation method"  
}
variable "eventhub_namespace_tags" {
    type = map(string)
    description = "eventhub_namespace tags"
}
variable "eventhub_namespace_subnet_id" {
    type = string
    description = "eventhub_namespace subnet_id"
}

variable "eventhub_namespace_ip_rules" {
    type = list(object({
      ip_mask = string
      action = string
    }))  
}

variable "network_rulesets" {
    type = list(object({
      subnet_id = string
    }))
  
}