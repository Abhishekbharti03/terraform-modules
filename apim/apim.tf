resource "azurerm_api_management" "apim" {
  
  name = var.apim_name
  location = var.apim_location
  resource_group_name = var.apim_resource_group_name
  sku_name = va.apim_sku_name
  publisher_email = var.publisher_email
  publisher_name = var.publisher_name
}