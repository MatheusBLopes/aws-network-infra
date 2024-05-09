terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "matheus-tf-state-bucket"
    key    = "quizhero-aws-network/terraform.tfstate"
    region = "us-east-1"
  }
}