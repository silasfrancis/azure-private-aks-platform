variable "env" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "aks_subnet_id" {
  type = string
}

variable "aks_managed_identity" {
  type = list(string)
}

variable "private_dns_zone_id" {
  type = string
}