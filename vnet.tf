resource "azurerm_virtual_network" "consul-cluster1" {
  name                = "network-${var.name}"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${var.rq}"
}
