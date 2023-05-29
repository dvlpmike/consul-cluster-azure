resource "azurerm_resource_group" "consul-cluster1" {
  name     = "rg-${var.rg}"
  location = "rg-${var.location}"
}
