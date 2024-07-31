# Brainboard auto-generated file.

resource "azurerm_resource_group" "vault-rg" {
  name     = "${var.prefix}-resources"
  location = "West US 2"

  tags = {
    Name = "Brainboard key vault"
  }
}

resource "azurerm_key_vault" "kv" {
  tenant_id           = var.tenantID
  sku_name            = "standard"
  resource_group_name = azurerm_resource_group.vault-rg.name
  name                = "${var.prefix}-key-vault"
  location            = "West US 2"

  tags = {
    Name = "Brainboard key vault"
  }
}

resource "azurerm_key_vault_access_policy" "current_user" {
  tenant_id    = var.tenantID
  object_id    = var.objectID
  key_vault_id = azurerm_key_vault.kv.id

  certificate_permissions = [
    "get",
    "import",
  ]
}

resource "azurerm_key_vault_access_policy" "web_app_resource_provider" {
  tenant_id    = var.web-tenantID
  object_id    = var.web-objectID
  key_vault_id = azurerm_key_vault.kv.id

  certificate_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]
}

resource "azurerm_key_vault_certificate" "kv-cert" {
  name         = "${var.prefix}-cert"
  key_vault_id = azurerm_key_vault.kv.id

  certificate {
    password = var.password
    contents = var.base64-certificate
  }

  certificate_policy {
    issuer_parameters {
      name = "Unknown"
    }
    key_properties {
      reuse_key  = false
      key_type   = "RSA"
      key_size   = 2048
      exportable = true
    }
    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }

  depends_on = [
    azurerm_key_vault_access_policy.current_user,
  ]

  tags = {
    Name = "Brainboard key vault certificate"
  }
}

resource "azurerm_app_service_certificate" "service_certificate" {
  resource_group_name = azurerm_resource_group.vault-rg.name
  name                = "${var.prefix}-cert"
  location            = "West US 2"
  key_vault_secret_id = azurerm_key_vault_certificate.kv-cert.secret_id

  tags = {
    Name = "Brainboard app service cert"
  }
}

