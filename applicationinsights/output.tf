output "applicationinsightsd" {
    value = azurerm_application_insights.applicationinsights.id
}

output "instrumentation_key" {
  description = "Instrumentation key provided by resource."
  value = azurerm_application_insights.applicationinsights.instrumentation_key
}

output "connection_stribg" {
    description = "Connection string provided by resource."
    value = azurerm_application_insights.applicationinsights.connection_string  
}