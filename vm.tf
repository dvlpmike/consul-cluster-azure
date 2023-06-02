resource "azurerm_linux_virtual_machine" "consul-cluster1" {
  count               = 3
  name                = "${var.name}${count.index}"
  resource_group_name = "${var.rg}"
  location            = "${var.location}"
  size                = "Standard_F2"
  admin_username      = "${var.user}"
  network_interface_ids = [
    azurerm_network_interface.adhocvm.id,
  ]

  admin_ssh_key {
    username   = "${var.user}"
    public_key = "${var.publickey}"
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
