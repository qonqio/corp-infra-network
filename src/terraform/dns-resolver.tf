
resource "azurerm_private_dns_resolver" "main" {

  name                = "dnspr-${var.application_name}-${var.environment_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  virtual_network_id  = azurerm_virtual_network.dns.id

}

resource "azurerm_private_dns_resolver_inbound_endpoint" "main" {

  name                    = "${azurerm_private_dns_resolver.main.name}-inbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.main.id
  location                = azurerm_private_dns_resolver.main.location

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.dns_resolver_inbound.id
  }

}

resource "azurerm_private_dns_resolver_outbound_endpoint" "main" {
  name                    = "${azurerm_private_dns_resolver.main.name}-outbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.main.id
  location                = azurerm_private_dns_resolver.main.location
  subnet_id               = azurerm_subnet.dns_resolver_outbound.id
}
