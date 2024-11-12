# s3-backend-setup.tf

provider "aws" {
  region  = var.REGION
  profile = var.PROFILE
}

# Variables
variable "bucket_name" {
  description = "The unique name for the S3 bucket to store Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table to lock Terraform state"
  type        = string
}

# Create S3 bucket for remote state storage
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  tags = {
    Name        = "terraform-state"
    Environment = "dev"
  }
}

# Create DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"  # No need to manage capacity
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-lock-table"
    Environment = "dev"
  }
}
