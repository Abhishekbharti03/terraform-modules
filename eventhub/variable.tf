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
