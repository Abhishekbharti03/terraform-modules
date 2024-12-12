resource "azurerm_container_registry" "acr" {
  lifecycle {
    prevent_destroy = true
    ignore_changes = [ network_rule_set ]
  }
  name                = var.containerregistry_name
  resource_group_name = var.containerregistry_rg
  location            = var.containerregistry_location
  sku                 = var.containerregistry_sku
  admin_enabled       = var.containerregistry_admin_enabled
  # admin_username                = var.containerregistry_admin_username
  anonymous_pull_enabled = var.containerregistry_anonymous_pull_enabled
  data_endpoint_enabled  = var.containerregistry_data_endpoint_enabled
  # login_server                  = var.containerregistry_login_server 
  quarantine_policy_enabled = var.containerregistry_quarantine_policy_enabled
  tags                      = var.containerregistry_tags
  network_rule_set = [{ default_action = "Deny"

    ip_rule = [{
      action   = "Allow"
      ip_range = var.allowed_ip_address
    }]
    virtual_network = []
  }]
  /* dynamic "network_rule_set" {
    for_each = var.network_rule_set != null ? [var.network_rule_set] : []
    content {
      default_action = "Deny"
      dynamic "ip_rule" {
        for_each = var.network_rule_set.ip_rule
        content {
          action   = "Allow"
          ip_range = ip_rule.value.ip_range
        }
      }
    }

  } */


  #dynamic "retention_policy" {
  #    for_each = var.retention_policy 
  #    content {
  #      days    = lookup(retention_policy.value, "days", 7)
  #      enabled = lookup(retention_policy.value, "enabled", true)
  #    }
  #  }
  #
  #  dynamic "trust_policy" {
  #    for_each = var.trust_policy 
  #    content {
  #      enabled = lookup(trust_policy.value, "enabled",)
  #    }
  #  }

}

# dynamic "retention_policy"  = {}
#           {
#              days    = 7
#              enabled = false
#             },
#         ] 
# trust_policy                  = var.containerregistry_trust_policy 
#   [
#         {
#             enabled = false
#             },
#         ] 
#   {
#           "#DataResidency" = "EU Only"
#           "#Environment"   = "D"
#           "#Segment"       = "CRB"
# }
