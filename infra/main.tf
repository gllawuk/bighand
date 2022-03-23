terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.6.0"
    }
  }
}

# europe (london)
provider "aws" {
  region = "eu-west-2"
}

provider "azurerm" {
  features {}
}