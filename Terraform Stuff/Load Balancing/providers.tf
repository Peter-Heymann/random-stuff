terraform {
  required_providers {
    azurerm = {
      version = "= 2.21.0"
    }
  }
}

provider "azurerm" {
  features {}
}
