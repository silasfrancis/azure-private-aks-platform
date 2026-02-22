variable "env" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "private_network_interface_id" {
  type = list(string)
}

variable "public_network_interface_ids" {
  type = list(string)
}


variable "vm_managed_identity" {
  type = list(string)
}

variable "jumphost_vm_managed_identity" {
  type = list(string)
}