terraform {
  required_version = ">=1.0.0"

  # Azurerm Backend https://www.terraform.io/docs/language/settings/backends/azurerm.html#
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate25210"
    container_name       = "tf-modules-azure-lb-advanced"
    key                  = "terraform.tfstate"
  }

  # #AWS Backend https://www.terraform.io/docs/language/settings/backends/s3.html
  # backend "s3" {
  #   bucket = "bucket_name"
  #   key    = "path/to/terraform.tfstate"
  #   region = "bucket_region"
  # }

  # #GCP Backend https://www.terraform.io/docs/language/settings/backends/gcs.html
  # backend "gcs" {
  #   bucket = <bucket_name"
  #   prefix = "path/to/terraform.tfstate"
  # }

  required_providers {
    # Uncomment required providers and delete unneeded
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }

    # aws = {
    #   version = ">= 3.20"
    #   source = "hashicorp/aws"
    # }

    # google = {
    #   version = ">= 3"
    #   source = "hashicorp/google"
    # }
    # google-beta = {
    #   version = ">= 3"
    #   source = "hashicorp/google-beta"
    # }
  }
}

# Uncomment required providers and delete unneeded

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Configure the AWS Provider
# provider "aws" {
#   region = "us-east-1"
# }

# Configure the GCP Provider
# provider "GCP" {
#   project = "project_name"
#   region  = "us-central1"
# }
