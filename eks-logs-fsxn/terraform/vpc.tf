data "aws_region" "current" {}
provider "aws" {
  region = var.aws_region
  profile = var.profile
  default_tags {
    tags = local.tags
  }
}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "group-name"
    values = [var.aws_region]
  }
}

locals {
  #cluster_name = "fsx-eks-${random_string.suffix.result}"
  cluster_name = "satreci-poc-${random_string.suffix.result}"
  tags = {
    project = "amazon-eks-fsx-for-netapp-ontap"
    owner   = "aws"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  #name                 = "fsxn-eks-vpc"
  name                 = "satreci-poc-vpc"  
  cidr                 = var.vpc_cidr
  #azs                  = data.aws_availability_zones.available.names
  #azs                  = slice(data.aws_availability_zones.available.names, 0, 3)
  azs = ["ap-northeast-2a", "ap-northeast-2c"]  
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24"]
  enable_nat_gateway   = true
  #single_nat_gateway   = true
  single_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
