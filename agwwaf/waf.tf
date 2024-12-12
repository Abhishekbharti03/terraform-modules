resource "azurerm_web_application_firewall_policy" "web_application_firewall" {
  name                = var.web_application_firewall_name
  resource_group_name = var.web_application_firewall_resource_group_name
  location            = var.web_application_firewall_location
  tags                = var.web_application_firewall_tags

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = var.request_body_check
    file_upload_limit_in_mb     = var.file_upload_limit_in_mb
    max_request_body_size_in_kb = var.max_request_body_size_in_kb
  }

  dynamic "custom_rules" {
    for_each = var.custom_rules
    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type
      action    = custom_rules.value.action

      dynamic "match_conditions" {
        for_each = custom_rules.value.match_conditions
        content {
          match_variables {
            variable_name = match_conditions.value.variable_name
          }
          operator           = match_conditions.value.operator
          negation_condition = match_conditions.value.negation_condition
          match_values       = match_conditions.value.match_values
        }
      }
    }
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }

    # Adding exclusions
    dynamic "exclusion" {
      for_each = var.exclusions
      content {
        match_variable          = exclusion.value.match_variable
        selector                = exclusion.value.selector
        selector_match_operator = exclusion.value.selector_match_operator
      }
    }
  }
}