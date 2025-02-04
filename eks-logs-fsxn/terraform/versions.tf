
terraform {
  required_version = ">= 0.12"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.26.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.39.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.3"
    }
  }

  backend "s3" {
    profile        = "eks-offer"
    bucket         = "satreci-poc-s3-backend"
    key            = "poc/apne2/eks-blue/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "satreci-poc-dynamodb-tfstate"
    acl            = "bucket-owner-full-control"
  }

}
