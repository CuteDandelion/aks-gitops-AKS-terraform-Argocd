output "kube_admin_config_raw" {
  description = "Raw (base64-encoded) admin kubeconfig"
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive   = true
}

output "kube_admin_host" {
  description = "Kubernetes API server endpoint"
  value       = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config[0].host : ""
  sensitive   = true
}

output "aks_host" {
  description = "The Kubernetes cluster API server host."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "aks_client_key" {
  description = "The client key for Kubernetes authentication."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive   = true
}

output "aks_client_certificate" {
  description = "The client certificate for Kubernetes authentication."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive   = true
}

output "aks_cluster_ca_certificate" {
  description = "The CA certificate for the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive   = true
}
