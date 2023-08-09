variable "rg" {
  description = "Resource Group Name"
  type        = string
  default     = "rg-consul-cluster"
}

variable "location" {
  description = "Location for resources"
  type        = string
  default     = "East US"
}

variable "name" {
  description = "Base name for resources"
  type        = string
  default     = "consul"
}

variable "ssh_user" {
  description = "SSH username for VMs"
  type        = string
  default     = "admin"
}

variable "public_key" {
  description = "SSH public key"
  type        = string
  default     = ""
}

