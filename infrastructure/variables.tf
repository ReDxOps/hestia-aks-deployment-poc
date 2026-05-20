variable "env" {
  description = "Nom de l'environnement cible"
  type        = string
  default     = "staging"
}

variable "rg_poc_hestia_aks_name" {
  description = "Nom du resource groupe du POC"
  type        = string
  default     = "rg_poc_hestia_aks"
}

variable "rg_poc_hestia_aks_location" {
  description = "Localisation du du resource groupe"
  type        = string
  default     = "France Central"
}

variable "vnet_poc_hestia_aks_cidr" {
  description = "Plage IP du vnet"
  type        = list(string)
}

variable "subnet_poc_hestia_aks_cidr" {
  description = "Plage IP du subnet"
  type        = list(string)
}
