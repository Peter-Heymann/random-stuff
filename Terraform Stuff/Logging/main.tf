resource "azurerm_resource_group" "resource-group" {
  tags     = merge(var.tags, {})
  name     = "rg-main"
  location = var.location
}

resource "azurerm_virtual_network" "virtual_network" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "vnet-kube"
  location            = var.location

  address_space = [
    var.vnet_main_addrspace,
  ]
}

resource "azurerm_subnet" "subnet_webapp" {
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.resource-group.name
  name                 = "WebAppSubnet"

  address_prefixes = [
    var.snet_kube_prefix,
  ]
}

resource "azurerm_public_ip" "public_ip_30_c_c" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "pip-kubernetes"
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "subnet_db" {
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.resource-group.name
  name                 = "DatabaseSubnet"

  address_prefixes = [
    var.snet_database_prefix,
  ]
}

resource "azurerm_mariadb_server" "mariadb_server" {
  version                       = "10.2"
  tags                          = merge(var.tags, {})
  storage_mb                    = 5120
  ssl_enforcement_enabled       = true
  sku_name                      = "B_Gen5_2"
  resource_group_name           = azurerm_resource_group.resource-group.name
  public_network_access_enabled = false
  name                          = "mariadb-demo"
  location                      = var.location
  geo_redundant_backup_enabled  = false
  backup_retention_days         = 7
  auto_grow_enabled             = true
  administrator_login_password  = var.db_pass
  administrator_login           = var.db_admin
}

resource "azurerm_mariadb_database" "mariadb_database" {
  server_name         = azurerm_mariadb_server.mariadb_server.id
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "mariadb_database"
  collation           = "utf8_general_ci"
  charset             = "utf8"
}

resource "azurerm_subnet" "subnet_monitoring" {
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.resource-group.name
  name                 = "snet_monitoring"

  address_prefixes = [
    var.snet_monitoring_prefix,
  ]
}

resource "azurerm_application_insights" "application_insights" {
  workspace_id        = azurerm_log_analytics_workspace.log_analytics_workspace.id
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "tf-test-appinsights"
  location            = var.location
  application_type    = "web"
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  tags                = merge(var.tags, {})
  sku                 = "PerGB2018"
  retention_in_days   = 30
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "acctest-01"
  location            = var.location
}

resource "azurerm_linux_web_app" "linux_web_app" {
  tags                = merge(var.tags, {})
  service_plan_id     = azurerm_service_plan.service_plan.id
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "linux-app"
  location            = var.location
}

resource "azurerm_service_plan" "service_plan" {
  tags                = merge(var.tags, {})
  sku_name            = "P1v2"
  resource_group_name = azurerm_resource_group.resource-group.name
  os_type             = "Linux"
  name                = "serviceplan"
  location            = var.location
}

resource "azurerm_storage_account" "storage_account" {
  tags                     = merge(var.tags, {})
  resource_group_name      = azurerm_resource_group.resource-group.name
  name                     = "storageaccountname"
  min_tls_version          = var.min_tls_version
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_monitor_action_group" "monitor_action_group" {
  tags                = merge(var.tags, {})
  short_name          = "p0action"
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "CriticalAlertsAction"
}

resource "azurerm_portal_dashboard" "portal_dashboard_45" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "my-dashboard"
  location            = var.location
}

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting_46" {
  target_resource_id         = azurerm_mariadb_server.mariadb_server.id
  storage_account_id         = azurerm_storage_account.storage_account.id
  name                       = "diagnostic setting"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  # Code not auto-generated by Brainboard
  log {
    category = "AuditEvent"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

