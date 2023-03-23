
## Terraform configuration ##

terraform {
  backend "s3" {
    bucket = "terraform-autozona"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

## Configure AWS Provider ##

provider "aws" {
  region  = var.region
  profile = var.profile
}


module "outputs" {
  source = "../"
}