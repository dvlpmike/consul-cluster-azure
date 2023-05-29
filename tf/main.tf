variable "name" {
  type = string
  default = "consul-cluster"
} 

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-${var.name}"
    storage_account_name = "sa-${var.name}"
    container_name       = "container-${var.name}"
    key                  = "${var.name}.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "${var.name}" {
  name     = "rg-${var.name}"
  location = "West Europe"
}
