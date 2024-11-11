###########################################
# AWS Providers
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
# Create ECR Repository
###########################################

resource "aws_ecr_repository" "checkpoint" {
  name                 = "checkpoint-task"
  image_tag_mutability = "MUTABLE"      
  tags                 = local.common_tags
  
  # lifecycle {
  #   prevent_destroy = true 
  # }
}