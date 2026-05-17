resource "azurerm_container_registry" "acr_poc_hestia_aks" {
  name                = "acrpochestiaaks"
  resource_group_name = azurerm_resource_group.rg_poc_hestia_aks.name
  location            = azurerm_resource_group.rg_poc_hestia_aks.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    environment = "shared"
  }
}
