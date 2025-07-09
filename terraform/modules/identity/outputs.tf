output "identity_id" {
  description = "Managed Identity resource ID"
  value       = azurerm_user_assigned_identity.this.id
}

output "principal_id" {
  description = "Managed Identity principal (object) ID"
  value       = azurerm_user_assigned_identity.this.principal_id
}
