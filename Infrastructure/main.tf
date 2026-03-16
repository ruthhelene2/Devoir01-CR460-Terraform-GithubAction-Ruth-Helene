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




# 9- Déploiement d’une VM à partir de votre pipeline dans MS Azure.
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-devoir01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
 
  admin_password                  = "P@ssw0rd1234!" # Utilisez des variables pour la sécurité en production
  disable_password_authentication = false
 
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
 
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}




# 10- Déploiement d’un container Docker à partir de votre pipeline dans MS Azure.
resource "azurerm_container_group" "aci" {
  name                = "aci-docker-Ruth"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-poly-Ruth-Helene-Moulen" # Changez ceci pour l'unicité
  os_type             = "Linux"
 
  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"
 
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
 

