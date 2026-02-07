resource "azurerm_resource_group" "app_rg" {
  name     = "CryptPitDevRG"
  location = "italynorth"
}

resource "azurerm_service_plan" "asp" {
  name                = "asp-dev"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "crypt-pit-dev-28450"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  service_plan_id     = azurerm_service_plan.asp.id

 site_config {
    app_command_line = ""
    application_stack {
      node_version = "18-lts"
    }
    
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "true"
    WEBSITE_RUN_FROM_PACKAGE            = "1"
  }
}


