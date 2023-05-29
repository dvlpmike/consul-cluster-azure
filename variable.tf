variable "name" {
  type = string
  default = "consul-cluster1"
} 

variable "vm" {
  type = object({
    location = "azurerm_resource_group.consul-cluster1.location"
    rg_name = "azurerm_resource_group.consul-cluster1.name"
  })
}
