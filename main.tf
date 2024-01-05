terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.31.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "logging" {
  source = "./modules/logging"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "lambda" {
  source = "./modules/lambda"
}
