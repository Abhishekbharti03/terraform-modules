resource "azurerm_eventhub_namespace" "eventhubnamespace" {

    name = var.eventhub_namespace_name
    resource_group_name = var.eventhub_namespace_resource_group_name
    location = var.eventhub_namespace_location
    sku = var.eventhub_namespace_sku
    capacity = var.eventhub_namespace_capacity
    tags = var.eventhub_namespace_tags
    minimum_tls_version = "1.2"
    local_authentication_enabled = var.eventhub_namespace_local_authentication_enabled
    
    identity {
      type = "SystemAssigned"
    }
  
}