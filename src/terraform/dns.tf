# Network we register DNS Zones and Setup a DNS Resolver
resource "azurerm_virtual_network" "dns" {

  name                = "vnet-${var.application_name}-dns-${var.environment_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.dns_address_space]

}

# Connect this Virtual Network to the Primary Virtual Hub
resource "azurerm_virtual_hub_connection" "main" {
  name                      = "dns-hub-connection"
  virtual_hub_id            = module.vwan.primary_virtual_hub_id
  remote_virtual_network_id = azurerm_virtual_network.dns.id
}


locals {
  dns_resolver_inbound_subnet_address_space  = cidrsubnet(var.dns_address_space, 4, 0)
  dns_resolver_outbound_subnet_address_space = cidrsubnet(var.dns_address_space, 4, 1)
}

# minimum subnet size of /28
# https://learn.microsoft.com/en-us/azure/dns/dns-private-resolver-overview
resource "azurerm_subnet" "dns_resolver_inbound" {

  name                            = "snet-dns-inbound"
  resource_group_name             = azurerm_resource_group.main.name
  virtual_network_name            = azurerm_virtual_network.dns.name
  address_prefixes                = [local.dns_resolver_inbound_subnet_address_space]
  default_outbound_access_enabled = false

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      name    = "Microsoft.Network/dnsResolvers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

}
resource "azurerm_subnet" "dns_resolver_outbound" {
  name                            = "snet-dns-outbound"
  resource_group_name             = azurerm_resource_group.main.name
  virtual_network_name            = azurerm_virtual_network.dns.name
  address_prefixes                = [local.dns_resolver_outbound_subnet_address_space]
  default_outbound_access_enabled = false

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}
