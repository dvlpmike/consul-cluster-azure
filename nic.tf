resource "azurerm_network_interface" "consul-cluster1" {
  name                = "nic-${var.name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"

  ip_configuration {
    name                          = "internal-network-${var.name}"
    subnet_id                     = azurerm_subnet.subnet-consul-cluster1.id
    private_ip_address_allocation = "Dynamic"
  }
}
