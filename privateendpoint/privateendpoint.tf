resource "azurerm_private_endpoint" "privateendpoint" {
  name                = var.privateendpoint_name
  location            = var.privateendpoint_location
  resource_group_name = var.privateendpoint_resource_group_name
  subnet_id           = var.privateendpoint_subnet_id
  
  dynamic "private_dns_zone_group" {
    for_each = var.ple_dns
  content {
    name = lookup(ple_dns.value, "name", null)
    #  var.privateendpoint_dns_name 
    # lookup(ple_dns.value, "name", null)
    private_dns_zone_ids = lookup(ple_dns.value, "private_dns_zone_ids", null)
    # var.privateendpoint_private_dns_zone_ids
  }
  }



 tags = var.privateendpoint_tags
  private_service_connection {
    name                           = var.privateendpoint_private_service_connection_name
    private_connection_resource_id = var.privateendpoint_private_connection_resource_id
    is_manual_connection           = var.privateendpoint_is_manual_connection
    subresource_names              = var.privateendpoint_subresource_names

  }
      # private_dns_zone_group = var.privateendpoint_dns_zone_group
    # private_service_connection = var.privateendpoint_service_connection
}
