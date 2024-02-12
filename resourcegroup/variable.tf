variable "resource_group_name" {
    type = string
    description = "resource group name"
}

variable "resource_group_location" {
    type = string
    description = "RG location"  
}

variable "resource_group_tags" {
    type = map(string)
    description = "RG tags"  
}