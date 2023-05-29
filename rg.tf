resource "azurerm_resource_group" "consul-cluster1" {
  name     = "rg-${var.name}"
  location = "West Europe"
}
