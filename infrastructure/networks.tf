
resource "azurerm_virtual_network" "vnet_poc_hestia_aks" {
  name                = "vnet-poc-hestia-aks-${var.env}"
  location            = azurerm_resource_group.rg_poc_hestia_aks.location
  resource_group_name = azurerm_resource_group.rg_poc_hestia_aks.name
  address_space       = var.vnet_poc_hestia_aks_cidr

  tags = {
    environment = var.env
  }
}

resource "azurerm_subnet" "subnet_poc_hestia_aks" {
  name                 = "subnet-aks"
  resource_group_name  = azurerm_resource_group.rg_poc_hestia_aks.name
  virtual_network_name = azurerm_virtual_network.vnet_poc_hestia_aks.name
  address_prefixes     = var.subnet_poc_hestia_aks_cidr

}
