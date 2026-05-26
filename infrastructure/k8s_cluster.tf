resource "azurerm_kubernetes_cluster" "k8s_cluster_poc_hestia_aks" {
  name                = "k8s-cluster-${var.env}"
  location            = azurerm_resource_group.rg_poc_hestia_aks.location
  resource_group_name = azurerm_resource_group.rg_poc_hestia_aks.name
  dns_prefix          = "hestia-k8s-${var.env}"

  default_node_pool {
    name                 = "nodes"
    node_count           = 1
    auto_scaling_enabled = false
    vm_size              = "Standard_D2s_v3"
    vnet_subnet_id       = azurerm_subnet.subnet_poc_hestia_aks.id
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "172.16.0.0/16"
    dns_service_ip    = "172.16.0.10"
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  tags = {
    Environment = var.env
  }
}

resource "azurerm_role_assignment" "aks_to_acr" {
  principal_id                     = azurerm_kubernetes_cluster.k8s_cluster_poc_hestia_aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr_poc_hestia_aks.id
  skip_service_principal_aad_check = true
}
