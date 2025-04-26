# IMPORTANT !!!
# https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns

resource "azurerm_private_dns_zone" "cosmosdb" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = azurerm_resource_group.main.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "cosmosdb" {

  name                  = "${var.application_name}-${var.environment_name}-cosmosdb"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.cosmosdb.name
  virtual_network_id    = azurerm_virtual_network.dns.id
  registration_enabled  = false

}

# https://learn.microsoft.com/en-us/azure/event-grid/configure-private-endpoints
resource "azurerm_private_dns_zone" "eventgrid" {
  name                = "privatelink.eventgrid.azure.com"
  resource_group_name = azurerm_resource_group.main.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "eventgrid" {

  name                  = "${var.application_name}-${var.environment_name}-eventgrid"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.eventgrid.name
  virtual_network_id    = azurerm_virtual_network.dns.id
  registration_enabled  = false

}

resource "azurerm_private_dns_zone" "keyvault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.main.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "keyvault" {

  name                  = "${var.application_name}-${var.environment_name}-keyvault"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault.name
  virtual_network_id    = azurerm_virtual_network.dns.id
  registration_enabled  = false

}

resource "azurerm_private_dns_zone" "storage_blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.main.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "storage_blob" {

  name                  = "${var.application_name}-${var.environment_name}-storage-blob"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_blob.name
  virtual_network_id    = azurerm_virtual_network.dns.id
  registration_enabled  = false

}

resource "azurerm_private_dns_zone" "service_bus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = azurerm_resource_group.main.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "service_bus" {

  name                  = "${var.application_name}-${var.environment_name}-service-bus"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.service_bus.name
  virtual_network_id    = azurerm_virtual_network.dns.id
  registration_enabled  = false

}
