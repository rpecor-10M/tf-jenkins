provider "azurerm" {
  version = "=1.44.0"
}

module "env-def" {
  source   = "../../modules/env-def"
  prefix   = "jenkinsinfra"
  env      = "dev"
  location = "eastus"
}