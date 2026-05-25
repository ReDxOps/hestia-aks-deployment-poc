resource "azurerm_user_assigned_identity" "pipeline_identity_poc_hestia_aks" {
  location            = azurerm_resource_group.rg_poc_hestia_aks.location
  name                = "id_pipeline_poc_hestia_aks-${var.env}"
  resource_group_name = azurerm_resource_group.rg_poc_hestia_aks.name
}

resource "azurerm_role_assignment" "pipeline_contributor" {
  scope                = azurerm_resource_group.rg_poc_hestia_aks.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.pipeline_identity_poc_hestia_aks.principal_id
}

resource "azurerm_role_assignment" "pipeline_acr_push" {
  scope                = azurerm_container_registry.acr_poc_hestia_aks.id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.pipeline_identity_poc_hestia_aks.principal_id
}

resource "azurerm_federated_identity_credential" "devops_federation" {
  name                      = "fed-devops-pipeline-${var.env}"
  user_assigned_identity_id = azurerm_user_assigned_identity.pipeline_identity_poc_hestia_aks.id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://vstoken.dev.azure.com/ReDxOps"
  subject                   = "sc://ReDxOps/hestia-aks-deployment-poc/sc-hestia-poc-staging"
}
