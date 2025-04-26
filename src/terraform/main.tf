data "azurerm_client_config" "current" {}

resource "random_string" "main" {
  length  = 8
  upper   = false
  special = false
}

locals {
  all_tags = merge(
    {
      application_name = var.application_name
      environment_name = var.environment_name
    },
    var.additional_tags
  )
}

resource "azurerm_resource_group" "main" {
  
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
  tags     = local.all_tags

}

import {
  to = module.vpn.azurerm_point_to_site_vpn_gateway.main
  id = "/subscriptions/9db8d5ac-a7c8-4882-9720-d0c3424699d7/resourceGroups/rg-qonq-vwan-prod/providers/Microsoft.Network/p2sVpnGateways/vpng-qonq-vwan-prod"
}
