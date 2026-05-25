output "pipeline_identity_client_id" {
  description = "Client ID for Azure DevOps"
  value       = azurerm_user_assigned_identity.pipeline_identity_poc_hestia_aks.client_id
}
