terraform {
  required_version = "= 1.0.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.62"
    }
  }

  backend "s3" {
    region = "ap-southeast-1"
    bucket = "terraform-state-bucket-grumbeard-powerx-1"
    key = "s3-backend.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
