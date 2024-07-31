resource "azurerm_resource_group" "rg-k8s" {
  name     = var.rg_name
  location = var.location

  tags = {
    Name = "Brainboard k8s"
    Env  = "Development"
  }
}

resource "azurerm_log_analytics_workspace" "brainboard-ws" {
  sku                 = var.log_analytics_workspace_sku
  resource_group_name = azurerm_resource_group.rg-k8s.name
  name                = "log-analytics-workspace-e89e764d"
  location            = var.location

  tags = {
    Name = "Brainboard k8s"
    Env  = "Development"
  }
}

resource "azurerm_log_analytics_solution" "log-analytics-solution-254258ce" {
  workspace_resource_id = azurerm_log_analytics_workspace.brainboard-ws.id
  workspace_name        = azurerm_log_analytics_workspace.brainboard-ws.name
  solution_name         = "ContainerInsights"
  resource_group_name   = azurerm_resource_group.rg-k8s.name
  location              = var.location

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "k8s-cluster" {
  resource_group_name = azurerm_resource_group.rg-k8s.name
  name                = var.cluster_name
  location            = var.location
  dns_prefix          = var.dns_prefix

  auto_scaler_profile {
    balance_similar_node_groups = true
  }

  default_node_pool {
    vm_size             = "Standard_D2_v2"
    node_count          = var.agent_count
    name                = "agentpool"
    enable_auto_scaling = true
  }

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = var.ssh_pub_key
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

  service_principal {
    client_secret = var.client_secret
    client_id     = var.client_id
  }

  tags = {
    Name = "Brainboard k8s"
    Env  = "Development"
  }
}

