resource "azurerm_resource_group" "consul-cluster1" {
  name     = "${var.rg}"
  location = "${var.location}"
}
