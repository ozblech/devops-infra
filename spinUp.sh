#!/bin/bash

# Start measuring time
SECONDS=0

if [ -z "$TF_VAR_REGION" ] || [ -z "$TF_VAR_PROFILE" ] || [ -z "$TF_VAR_ACCOUNT" ]; then
    echo "One or more required environment variables are not set:"    
    [ -z "$TF_VAR_REGION" ] && echo "  - TF_VAR_REGION is not set (example: export TF_VAR_REGION=us-east-2)"
    [ -z "$TF_VAR_PROFILE" ] && echo "  - TF_VAR_PROFILE is not set (example: export TF_VAR_PROFILE=poc)"
    [ -z "$TF_VAR_ACCOUNT" ] && echo "  - TF_VAR_ACCOUNT is not set (example: export TF_VAR_ACCOUNT=123456789012)"
    exit 1
fi

echo "AWS_REGION: $TF_VAR_REGION"
echo "AWS_PROFILE: $TF_VAR_PROFILE"
echo "AWS_ACCOUNT_ID: $TF_VAR_ACCOUNT"



############################
# Functions
############################

# Function to change directory, run make commands, and handle errors
function deploy_component {
    local component_dir=$1
    cd "$component_dir" || { echo "Failed to enter directory $component_dir"; exit 1; }
    
    echo "Initializing and applying for $component_dir..."
    make init && make apply-auto-approve || { echo "Failed to deploy $component_dir"; exit 1; }
    
    cd .. || exit
}

# Function to check if a command exists
function check_command {
    command -v "$1" >/dev/null 2>&1 || { echo "$1 is not installed. Please install it." >&2; exit 1; }
}


############################
# Infrastracture Deployment
############################

# Check required commands
check_command "aws"       # Check if AWS CLI is installed
check_command "terraform"  # Check if Terraform is installed
check_command "kubectl"    # Check if kubectl is installed

# Deploy each component
deploy_component "01-Backend"
deploy_component "02-EKS"
deploy_component "03-ECR"
cd ..


# Load first image to ECR

#???
aws eks --region $AWS_REGION --profile $AWS_PROFILE update-kubeconfig --name checkpoint-eks-cluster
# Set the Endpoint as an Environment Variable
export EKS_API_SERVER=$(aws eks describe-cluster --name checkpoint-eks-cluster --query "cluster.endpoint" --output text)



echo "Total execution time: $SECONDS seconds."
echo "Done!, Finish up with the manual steps in the README.md file."
