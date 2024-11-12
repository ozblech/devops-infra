###########################################
# 1. Configure the backend for remote state in S3
###########################################
terraform {
  backend "s3" {
    bucket         = "chekcpoint-oz-blech-state-bucket"  
    key            = "eks-cluster/terraform.tfstate"
    region         = "ap-southeast-2"                  
    dynamodb_table = "terraform-lock-table"             
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.61.0"
    }
  }
}


###########################################
# 2. Define AWS Provider
###########################################
provider "aws" {
  region  = var.REGION
  profile = var.PROFILE

}
terraform { 
  required_version = ">= 1.9"
}


# Define Public Subnets
locals {
  common_tags = {
    Owner      = var.aws.Owner
    Objective  = var.aws.Objective
    Name       = var.aws.Name
  }
}


###########################################
# 3. Create ECR Repository
###########################################

resource "aws_ecr_repository" "checkpoint" {
  name                 = "checkpoint-task"
  image_tag_mutability = "MUTABLE"      
  tags                 = local.common_tags
  
  # lifecycle {
  #   prevent_destroy = true 
  # }
}