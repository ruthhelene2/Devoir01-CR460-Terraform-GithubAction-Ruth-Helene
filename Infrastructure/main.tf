# 7. Déploiement de ressource groupe à partir de votre pipeline dans MS Azure.
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# 8- Déploiement de Réseau Virtuel à partir de votre pipeline dans MS Azure.
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-devoir01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}
 
# LE SOUS-RÉSEAU (L'élément manquant indispensable pour la VM)
resource "azurerm_subnet" "subnet" {
  name                 = "snet-internal-devoir01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
 
# Interface Réseau pour la VM
resource "azurerm_network_interface" "nic" {
  name                = "nic-vm-devoir01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id # Connexion au subnet ici
    private_ip_address_allocation = "Dynamic"
  }
}