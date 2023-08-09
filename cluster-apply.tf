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

resource "azurerm_resource_group" "consul-cluster-azure" {
  name     = var.rg
  location = var.location
}

resource "azurerm_virtual_network" "consul-cluster-azure" {
  name                = "network-${var.name}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg
}

resource "azurerm_subnet" "consul-cluster-azure" {
  name                 = "lan-${var.name}"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.consul-cluster-azure.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "consul-cluster-azure" {
  name                = "publicIPForLB"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
}

resource "azurerm_lb" "consul-cluster-azure" {
  name                = "loadBalancer"
  location            = var.location
  resource_group_name = var.rg

  frontend_ip_configuration {
    name                 = "publicIPAddress"
    public_ip_address_id = azurerm_public_ip.consul-cluster-azure.id
  }
}

resource "azurerm_lb_backend_address_pool" "consul-cluster-azure" {
  loadbalancer_id = azurerm_lb.consul-cluster-azure.id
  name            = "BackEndAddressPool"
}

resource "azurerm_network_interface" "consul-cluster-azure" {
  count               = 3
  name                = "nic-${var.name}${count.index}"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal-network-${var.name}"
    subnet_id                     = azurerm_subnet.consul-cluster-azure.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "consul-cluster-azure" {
  count               = 3
  name                = "${var.name}${count.index}"
  resource_group_name = var.rg
  location            = var.location
  size                = "Standard_DS1"
  admin_username      = var.ssh_user
  network_interface_ids = [azurerm_network_interface.consul-cluster-azure[count.index].id]

  admin_ssh_key {
    username   = var.ssh_user
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "${var.name}${count.index}"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
