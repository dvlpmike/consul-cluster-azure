resource "azurerm_network_interface" "consul-cluster1" {
  count               = 3
  name                = "nic-${var.name}${count.index}"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"

  ip_configuration {
    name                          = "internal-network-${var.name}"
    subnet_id                     = azurerm_subnet.consul-cluster1.id
    private_ip_address_allocation = "Dynamic"
  }
}
