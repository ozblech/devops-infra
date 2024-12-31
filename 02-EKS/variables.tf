variable "aws" {
  type = map(string)
}

variable "PROFILE" {
  description = "The AWS profile used for this account"
  type        = string
}

variable "REGION" {
  description = "The region used for this account"
  type        = string
}

//variable "ACCOUNT" {
//  description = "The id used for this account"
//  type        = string
//}

variable "eks" {
  type = object({
    cluster_name = string
    eks_version  = string
    instance_type = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
      max_unavailable = number
    })
  })
} 