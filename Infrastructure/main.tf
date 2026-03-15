# 7. Déploiement de ressource groupe à partir de votre pipeline dans MS Azure.
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
