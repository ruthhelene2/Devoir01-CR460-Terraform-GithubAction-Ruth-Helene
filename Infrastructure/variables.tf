# variables.tf
variable "tp_api_token" {
  type        = string
  description = "Le jeton d'API pour l'infrastructure"
  sensitive   = true
  # Pas de valeur par défaut ici par sécurité, elle viendra de GitHub Secrets
}
 
variable "resource_group_name" {
  type        = string
  description = "Nom du groupe de ressources Azure"
  default     = "rg-Poly-Cyber-CR460-Dev01" # Valeur par défaut
}
 
variable "location" {
  type        = string
  description = "La région Azure"
  default     = "West Europe"    # Valeur par défaut
}
