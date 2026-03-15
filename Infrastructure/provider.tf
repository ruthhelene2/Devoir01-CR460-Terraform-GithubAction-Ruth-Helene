# Terraform Block
terraform {
  cloud {
        organization = "Polymtl-Cyber-CR460-Dev01" 
    workspaces {
      name = "Ruth-Helene-Devoir01-CR460-H26"
    }
  }
 
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
 
# Provider Block
provider "azurerm" {
  features {}
}
