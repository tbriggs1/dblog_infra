terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
    backend "s3" {
      bucket = "tombriggs-my-terraform-state-bucket"
      key = "envs/prod/terraform.tfstate"
      region = "eu-west-1"
      encrypt = true
    }
}

provider "aws" {
  region = "eu-west-1"
}