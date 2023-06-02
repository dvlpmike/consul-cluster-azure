terraform {
  backend "azurerm" {
    resource_group_name  = "rg-consul-cluster"
    storage_account_name = "saconsulcluster"
    container_name       = "container-consul-cluster"
    key                  = "consul-cluster.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "consul-cluster1" {
  name     = "${var.rg}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "consul-cluster1" {
  name                = "network-${var.name}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg
}

resource "azurerm_subnet" "consul-cluster1" {
  name                 = "lan-${var.name}"
  resource_group_name  = var.rg
  virtual_network_name = "network-${var.name}"
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "consul-cluster1" {
  count               = 3
  name                = "nic-${var.name}${count.index}"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal-network-${var.name}"
    subnet_id                     = azurerm_subnet.consul-cluster1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "consul-cluster1" {
  count               = 3
  name                = "${var.name}${count.index}"
  resource_group_name = var.rg
  location            = var.location
  size                = "Standard_DS1"
  admin_username      = var.ssh_user
  network_interface_ids = [azurerm_network_interface.consul-cluster1[count.index].id]

  admin_ssh_key {
    username   = var.ssh_user
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }
}
