variable "name" {
  type = string
  default = "consul-cluster"
} 

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-consul-cluster"
    storage_account_name = "sa-consul-cluster"
    container_name       = "container-consul-cluster"
    key                  = "consul-cluster.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "consul-cluster" {
  name     = "rg-${var.name}"
  location = "West Europe"
}
