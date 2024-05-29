resource "azurerm_resource_group" "georgeibrahim" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "georgevn" {
  name                = "george-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
}

resource "azurerm_subnet" "georgesb" {
  name                 = "george_sb"
  resource_group_name  = azurerm_resource_group.georgeibrahim.name
  virtual_network_name = azurerm_virtual_network.georgevn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "georgenic" {
  name                = "george-nic"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.georgesb.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "georgevm1" {
  name                = "george-machine1"
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  location            = azurerm_resource_group.georgeibrahim.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.georgenic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
resource "azurerm_windows_virtual_machine" "georgevm2" {
  name                = "george-machine2"
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  location            = azurerm_resource_group.georgeibrahim.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.georgenic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

resource "azurerm_mssql_server" "georgesql" {
  name                         = "georgemssqlserver"
  resource_group_name          = azurerm_resource_group.georgeibrahim.name
  location                     = azurerm_resource_group.georgeibrahim.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = "00000000-0000-0000-0000-000000000000"
  }

  tags = {
    environment = "production"
  }
}
resource "azurerm_web_application_firewall_policy" "georgewaf" {
  name                = "george-wafpolicy"
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  location            = azurerm_resource_group.georgeibrahim.location

  custom_rules {
    name      = "Rule1"
    priority  = 1
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }

      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["192.168.1.0/24", "10.0.0.0/24"]
    }

    action = "Block"
  }

  custom_rules {
    name      = "Rule2"
    priority  = 2
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }

      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["192.168.1.0/24"]
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
