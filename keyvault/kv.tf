data "azurerm_client_config" "current" {}



resource "azurerm_key_vault" "keyvault" {
  lifecycle {
  ignore_changes = [ access_policy, network_acls ]
  prevent_destroy = true
}
  name                        = var.keyvault_name
  location                    = var.keyvault_location
  resource_group_name         = var.keyvault_resource_group_name
  enabled_for_disk_encryption = var.keyvault_disk_encryption
  tenant_id                   = var.keyvault_tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = var.keyvault_purge_protection

  sku_name = var.keyvault_sku

#  dynamic "access_policy" {
#  for_each = var.access_policy_1
#  content {
#  tenant_id               = access_policy.value["tenant_id"]
#  object_id               = access_policy.value["object_id"]
#  key_permissions         = access_policy.value["key_permissions"]
#  secret_permissions      = access_policy.value["secret_permissions"]
#  certificate_permissions = access_policy.value["certificate_permissions"]
#  }
#  }
#
#  access_policy {
#  tenant_id               = var.access_policy_tenant_id
#  object_id               = var.access_policy_object_id
#  key_permissions         = var.access_policy_key_permissions
#  secret_permissions      = var.access_policy_secret_permissions
#  certificate_permissions = var.access_policy_certificate_permissions
#  }

}