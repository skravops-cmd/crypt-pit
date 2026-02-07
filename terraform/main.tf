resource "azurerm_resource_group" "app_rg" {
  name     = "CryptPitDevRG"
  location = "italynorth"
}

resource "azurerm_static_site" "cryptpit" {
  name                = "cryptpit-dev-28450"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  sku_tier            = "Free"

  repository_url = "https://github.com/skravops-cmd/crypt-pit"
  branch         = "main"

  build_properties {
    app_location    = "app" # index.html folder app
    api_location    = ""    # no API
    output_location = "."   # static files go at root
  }
}

