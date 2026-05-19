resource "azurerm_key_vault" "key_vault_poc_hestia_aks" {
  name                        = "kv-hestia-${var.env}"
  location                    = azurerm_resource_group.rg_poc_hestia_aks.location
  resource_group_name         = azurerm_resource_group.rg_poc_hestia_aks.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "default_access_policy_poc_hestia_aks" {
  key_vault_id = azurerm_key_vault.key_vault_poc_hestia_aks.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge"
  ]
}

resource "azurerm_key_vault_access_policy" "k8s_access_policy_poc_hestia_aks" {
  key_vault_id = azurerm_key_vault.key_vault_poc_hestia_aks.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_kubernetes_cluster.k8s_cluster_poc_hestia_aks.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = [
    "Get",
    "List"
  ]
}
