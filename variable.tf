variable "name" {
  type = string
  default = "consul-cluster1"
}

variable "rg" {
  type = string
  default = "rg-${var.name}"
}

variable "location" {
  type = string
  default = "West Europe"
}

