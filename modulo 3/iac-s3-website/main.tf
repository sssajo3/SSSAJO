terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "s3_website" {
  source      = "./modules/s3_static_website"
  bucket_name = var.bucket_name
  owner       = var.owner
  region      = var.region
}