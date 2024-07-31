locals {
  backend_address_pool_name = "${local.prefix}-beap"

  frontend_ip_configuration_name = "${local.prefix}-feip"

  frontend_port_name = "${local.prefix}-feport"

  http_setting_name = "${local.prefix}-be-htst"

  listener_name = "${local.prefix}-httplstn"

  prefix = "demo"

  redirect_configuration_name = "${local.prefix}-rdrcfg"

  request_routing_rule_name = "${local.prefix}-rqrt"

}
