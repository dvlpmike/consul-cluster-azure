resource "azurerm_virtual_network" "consul-cluster1" {
  name                = "network-${var.name}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.consul-cluster1.location
  resource_group_name = azurerm_resource_group.consul-cluster1.name
}
