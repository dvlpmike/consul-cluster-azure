terraform {
  backend "azurerm" {
    resource_group_name  = "rg-consul-cluster"
    storage_account_name = "saconsulcluster"
    container_name       = "container-consul-cluster"
    key                  = "consul-cluster.tfstate"
  }
}

variable "name" {
  type = string
  default = "consul-cluster1"
} 

provider "azurerm" {
  features {}
  use_oidc = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "consul-cluster1" {
  name     = "rg-${var.name}"
  location = "West Europe"
}
