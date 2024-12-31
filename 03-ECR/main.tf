###########################################
# 1. Configure the backend for remote state in S3
###########################################
terraform {
  backend "s3" {
    bucket         = "checkpoint-oz-blech-state-bucket"  
    key            = "ecr/terraform.tfstate"
    region         = "eu-west-3"                  
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

resource "aws_ssm_parameter" "aws_ecr_repository" {
  name  = "/checkpoint/ecr_repository"
  type  = "String"
  value = aws_ecr_repository.checkpoint.repository_url
}