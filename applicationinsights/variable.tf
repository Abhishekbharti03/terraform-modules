variable "application_insights_name" {
    type = string
    description = "application insights nanme"  
}

variable "application_insights_type" {
    type = string
    description = "application insight type"
  
}

variable "application_insights_location" {
    type = string
    description = "application insights location"
  
}

variable "application_insights_resource_group_name" {
    type = string
    description = "application insights RG name"
  
}

variable "application_insights_sampling_percentage" {
    type = string
    description = "application insights sampling percentage"
  
}

variable "application_insights_tags" {
    type = map(string)
    description = "application insghts tags"
  
}