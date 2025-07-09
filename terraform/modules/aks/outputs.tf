output "kube_admin_config_raw" {
  description = "Raw (base64-encoded) admin kubeconfig"
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive   = true
}

output "kube_admin_host" {
  description = "Kubernetes API server endpoint"
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
}
