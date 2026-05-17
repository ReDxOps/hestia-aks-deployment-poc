
resource "azurerm_resource_group" "rg_poc_hestia_aks" {
  name     = "${var.rg_poc_hestia_aks_name}-${var.env}"
  location = var.rg_poc_hestia_aks_location
}
