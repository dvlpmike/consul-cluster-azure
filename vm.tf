resource "azurerm_linux_virtual_machine" "consul-cluster1" {
  count               = 3
  name                = "${var.name}${count.index}"
  resource_group_name = "${var.rg}"
  location            = "${var.location}"
  size                = "Standard_F2"
  admin_username      = "${var.ssh_user}"
  network_interface_ids = [
    azurerm_network_interface.consul-cluster1.id,
  ]

  admin_ssh_key {
    username   = "${var.ssh_user}"
    public_key = "${var.public_key}"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
