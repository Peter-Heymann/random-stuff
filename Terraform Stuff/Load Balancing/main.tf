resource "azurerm_availability_set" "tf_avset" {
  resource_group_name          = azurerm_resource_group.tf_rg.name
  platform_update_domain_count = 2
  platform_fault_domain_count  = 2
  name                         = "${var.dns_name}avset"
  managed                      = true
  location                     = "West Europe"

  tags = {
    env = "test"
  }
}

resource "azurerm_lb" "tf_lb" {
  resource_group_name = azurerm_resource_group.tf_rg.name
  name                = "${var.rg_prefix}lb"
  location            = "West Europe"

  frontend_ip_configuration {
    public_ip_address_id = azurerm_public_ip.tf_lbpip.id
    name                 = "LoadBalancerFrontEnd"
  }

  tags = {
    env = "test"
  }
}

resource "azurerm_lb_backend_address_pool" "tf_backend_pool" {
  resource_group_name = azurerm_resource_group.tf_rg.name
  name                = "BackendPool1"
  loadbalancer_id     = azurerm_lb.tf_lb.id
}

resource "azurerm_lb_nat_rule" "tf_tcp" {
  resource_group_name            = azurerm_resource_group.tf_rg.name
  protocol                       = "tcp"
  name                           = "SSH-VM-${count.index}"
  loadbalancer_id                = azurerm_lb.tf_lb.id
  frontend_port                  = 443
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  count                          = 2
  backend_port                   = 22
}

resource "azurerm_lb_probe" "tf_lb_probe" {
  resource_group_name = azurerm_resource_group.tf_rg.name
  protocol            = "tcp"
  port                = 80
  number_of_probes    = 2
  name                = "tcpProbe"
  loadbalancer_id     = azurerm_lb.tf_lb.id
  interval_in_seconds = 5
}

resource "azurerm_lb_rule" "azurerm_lb_rule-e4d5938d" {
  resource_group_name            = azurerm_resource_group.tf_rg.name
  protocol                       = "tcp"
  probe_id                       = azurerm_lb_probe.tf_lb_probe.id
  name                           = "LBRule"
  loadbalancer_id                = azurerm_lb.tf_lb.id
  idle_timeout_in_minutes        = 5
  frontend_port                  = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  backend_port                   = 80
  backend_address_pool_id        = azurerm_lb_backend_address_pool.tf_backend_pool.id

  depends_on = [
    azurerm_lb_probe.tf_lb_probe,
  ]
}

resource "azurerm_linux_virtual_machine" "tf_vm" {
  size                = var.vm_size
  resource_group_name = azurerm_resource_group.tf_rg.name
  name                = "vm${count.index}"
  location            = "West Europe"
  count               = 2
  computer_name       = var.hostname
  availability_set_id = azurerm_availability_set.tf_avset.id
  admin_username      = "root"
  admin_password      = "azerty"

  network_interface_ids = [
    "${element(azurerm_network_interface.nic.*.id, count.index)}",
  ]

  os_disk {
    name = "osdisk${count.index}"
  }

  source_image_reference {
    version   = var.image_publisher.version
    sku       = var.image_publisher.sku
    publisher = var.image_publisher.publisher
    offer     = var.image_publisher.offer
  }

  tags = {
    env = "test"
  }
}

resource "azurerm_network_interface" "tf_nic" {
  resource_group_name = azurerm_resource_group.tf_rg.name
  name                = "nic${count.index}"
  location            = "West Europe"
  count               = 2

  ip_configuration {
    subnet_id                     = azurerm_subnet.tf_subnet.id
    private_ip_address_allocation = "Dynamic"
    name                          = "ipconfig${count.index}"
  }

  tags = {
    env = "test"
  }
}

resource "azurerm_network_interface_nat_rule_association" "azurerm_network_interface_nat_rule_association-55ee81ea" {
  network_interface_id  = element(azurerm_network_interface.nic.*.id, count.index)
  nat_rule_id           = element(azurerm_lb_nat_rule.tcp.*.id, count.index)
  ip_configuration_name = "ipconfig${count.index}"
  count                 = 2
}

resource "azurerm_public_ip" "tf_lbpip" {
  resource_group_name = azurerm_resource_group.tf_rg.name
  name                = "${var.rg_prefix}-ip"
  location            = "West Europe"
  domain_name_label   = "${var.lb_ip_dns_name}"
  allocation_method   = "Dynamic"

  tags = {
    env = "test"
  }
}

resource "azurerm_resource_group" "tf_rg" {
  name     = var.resource_group
  location = "West Europe"

  tags = {
    env = "test"
  }
}

resource "azurerm_storage_account" "tf_stor" {
  resource_group_name      = azurerm_resource_group.tf_rg.name
  name                     = "${var.dns_name}stor"
  location                 = "West Europe"
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type

  tags = {
    env = "test"
  }
}

resource "azurerm_subnet" "tf_subnet" {
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  resource_group_name  = azurerm_resource_group.tf_rg.name
  name                 = "${var.rg_prefix}subnet"

  address_prefixes = [
    "${var.subnet_prefix}",
  ]
}

resource "azurerm_virtual_network" "tf_vnet" {
  resource_group_name = azurerm_resource_group.tf_rg.name
  name                = var.virtual_network_name
  location            = "West Europe"

  address_space = [
    "10.0.0.0/16",
  ]

  tags = {
    env = "test"
  }
}

