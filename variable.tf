variable "name" {
  type = string
  default = "consul-cluster-azure"
}

variable "rg" {
  type = string
  default = "rg-consul-cluster1"
}

variable "location" {
  type = string
  default = "centralus"
}

variable "public_key" {}

variable "ssh_user" {}
