resource "azurerm_application_insights" "applicationinsights" {

    application_type = var.application_insights_type
    location = var.application_insights_location
    name = var.application_insights_name
    resource_group_name = var.application_insights_resource_group_name
    sampling_percentage = var.application_insights_sampling_percentage
    tags = var.application_insights_tags
  
}