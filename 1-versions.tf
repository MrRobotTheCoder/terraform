# Terraform Block
terraform {
  required_version = "~> 1.12.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.2.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

# Provider Block
provider "aws" {
    region = var.aws_region
}

# Create Random Pet Resource
resource "random_pet" "this" {
  length = 2
}