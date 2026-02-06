terraform {
  backend "azurerm" {
    resource_group_name  = "TerraformStateRG"
    storage_account_name = "tfstate2064812825"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

