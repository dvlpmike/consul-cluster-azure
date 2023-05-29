resource "azurerm_subnet" "consul-cluster1" {
  name                 = "subnet-${var.name}"
  resource_group_name  = "${var.rg}"
  virtual_network_name = "network-${var.name}"
  address_prefixes     = ["10.0.1.0/24"]
}
