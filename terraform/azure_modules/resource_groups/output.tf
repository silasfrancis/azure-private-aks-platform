output "resource_group_id" {
  value = data.azurerm_resource_group.env.id
}

output "resource_group_location" {
  value = data.azurerm_resource_group.env.location
}

output "resource_group_name" {
  value = data.azurerm_resource_group.env.name
}