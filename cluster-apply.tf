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
