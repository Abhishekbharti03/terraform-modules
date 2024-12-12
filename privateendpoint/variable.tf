variable "privateendpoint_name" {
  type=string
  description = "privateendpoint name"
}
variable "privateendpoint_location" {
  type=string
  description = "privateendpointlocation"
}
variable "privateendpoint_resource_group_name" {
  type=string
  description = "privateendpoint_resource_group name"
}
variable "privateendpoint_subnet_id" {
  type=string
  description = "privateendpoint subnetid"
}
# variable "privateendpoint_dns_zone_group" {
#   type=string
#   description = "privateendpoint dns_zone_group"
# }
# variable "privateendpoint_service_connection" {
#   type=string
#   description = "privateendpoint service_connection"
# }
variable "privateendpoint_tags" {
  type=map(string)
  description = "privateendpoint tags"
}
# variable "privateendpoint_dns_name" {
#   type=string
#   description = "privateendpoint_dns name"
# }
# variable "privateendpoint_private_dns_zone_ids" {
#   type=list(string)
#   description = "privateendpoint_private_dns_zone_ids"
# }

variable "privateendpoint_private_service_connection_name" {
  type=string
  description = "privateendpoint_private_service_connection name"
}
variable "privateendpoint_private_connection_resource_id" {
  type=string
  description = "privateendpoint_private_connection_resource id"
}
variable "privateendpoint_is_manual_connection" {
  type=bool
  description = "privateendpoint_is_manual connection"
}
variable "privateendpoint_subresource_names" {
  type= list(string)
  description = "privateendpoint_subresource names"
}

variable "ple_dns" {
  type=list(object({
   private_dns_zone_ids   = list(string)
      name       = string

}))
description = "ple_dns"
default = []
}