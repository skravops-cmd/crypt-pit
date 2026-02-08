terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {}

# Resource Group
resource "azurerm_resource_group" "app_rg" {
  name     = "CryptPitDevRG"
  location = "westeurope"
}

# Static Web App
resource "azapi_resource" "static_site" {
  type      = "Microsoft.Web/staticSites@2022-03-01"
  name      = "cryptpit-dev-28450"
  parent_id = azurerm_resource_group.app_rg.id

  location = azurerm_resource_group.app_rg.location


  body = {
    sku = {
      name = "Free"
      tier = "Free"
    }

    properties = {}
  }
}


# 3️⃣ Output
output "static_web_app_name" {
  value = azapi_resource.static_site.name
}

