terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.4"
    }
  }

  required_version = "~> 1.3"
}

provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "matheus-tf-state-bucket"
    key    = "infra-eks-ecr/terraform.tfstate"
    region = "us-east-1"
  }
}