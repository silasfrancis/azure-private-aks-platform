variable "env" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "network_interface_ids" {
  type = list(string)
}

variable "vm_managed_identity" {
  type = list(string)
}