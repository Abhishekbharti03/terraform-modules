variable "keyvault_name" {
type = string  
}

variable "keyvault_location" {
  type = string
}

variable "keyvault_resource_group_name" {
    type = string 
}

variable "keyvault_tenant_id" {
  type = string
  
}

variable "keyvault_disk_encryption" {
  type = bool
}

variable "keyvault_purge_protection" {
  type = bool
}

variable "keyvault_sku" {
type = string  
}




variable "access_policy_1" {
  type=list(object({
  tenant_id               = string
  object_id               = string
  key_permissions         = list(string)
  secret_permissions      = list(string)
  certificate_permissions     = list(string)
     
      
  
}))

default = []

description = "access policy"
}

variable "access_policy_tenant_id" {
  type = string
  default = ""
}

variable "access_policy_object_id" {
  type = string
  default = ""
}

variable "access_policy_key_permissions" {
  type = list(string)
  default = []
}

variable "access_policy_secret_permissions" {
  type = list(string)
  default = []
}

variable "access_policy_certificate_permissions" {
  type = list(string)
  default = []
}