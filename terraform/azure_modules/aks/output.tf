output "cluster_id" {
  value = azurerm_kubernetes_cluster.k8_cluster.id
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.k8_cluster.name
}

output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.k8_cluster.oidc_issuer_url
}