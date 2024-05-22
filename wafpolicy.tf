/*
locals{
  waf_policy=[for f in fileset("${path.module}/waffolder", "[^_]*.yaml") : yamldecode(file("${path.module}/waffolder/${f}"))]
  azurewafpolicy_list = flatten([
    for app in local.waf_policy: [
      for azurewaf in try(app.listofwafpolicy, []) :{
        name=azurewaf.policyname
      }
    ]
])
}

resource "azurerm_web_application_firewall_policy" "georgeibrahim" {
  for_each            ={for sp in local.azurewafpolicy_list: "${sp.name}"=>sp }
  name                = each.value.name
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  location            = azurerm_resource_group.georgeibrahim.location

  custom_rules {
    name      = var.custom_rules1_name
    priority  = var.custom_rules1_priority
    rule_type = var.custom_rules1_rule_type

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }

      operator           = "IPMatch"
      negation_condition = false
      match_values       = var.list1_match_values
    }

    action = "Block"
  }

  custom_rules {
    name      = var.custom_rules2_name
    priority  = var.custom_rules2_priority
    rule_type = var.custom_rules2_rule_type

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }

      operator           = "IPMatch"
      negation_condition = false
      match_values       = var.list2_match_values
    }

    match_conditions {
      match_variables {
        variable_name = "RequestHeaders"
        selector      = "UserAgent"
      }

      operator           = "Contains"
      negation_condition = false
      match_values       = ["Windows"]
    }

    action = "Block"
  }

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
    }
    exclusion {
      match_variable          = "RequestCookieNames"
      selector                = "too-tasty"
      selector_match_operator = "EndsWith"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        rule {
          id      = "920300"
          enabled = true
          action  = "Log"
        }

        rule {
          id      = "920440"
          enabled = true
          action  = "Block"
        }
      }
    }
  }
}

variable "custom_rules1_name"{
  type=string
}
variable "custom_rules2_name"{
  type=string
}
variable "custom_rules1_rule_type"{
  type=string
}
variable "custom_rules2_rule_type"{
  type=string
}
variable "custom_rules1_priority"{
  type=number
}
variable "custom_rules2_priority"{
  type=number
}
variable  "list1_match_values"{
  type =list(string)
}
variable  "list2_match_values"{
  type =list
}
*/
