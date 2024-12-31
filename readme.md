EKS Service Deployment Project
Description
This project demonstrates the deployment of an EKS (Elastic Kubernetes Service) environment for hosting a Python-based application forked from Counter-service App.

Project Features
VPC Creation: Sets up a Virtual Private Cloud (VPC) to host the EKS cluster.
EKS Deployment: Deploys the application and its dependencies in the EKS environment.
ECR (Elastic Container Registry): Stores Docker images for the application.

Namespace Structure
The EKS cluster uses the following namespaces:
counter-service: Contains the Python application.


Load Balancing
A public LoadBalancer is set up for the application namespace to handle internet traffic, while database access remains secure within a private network.


Getting Started
Prerequisites
AWS CLI
kubectl
Docker
Terraform

Setup Instructions
Clone the repository:
git clone https://github.com/ozblech/devops-infra.git
cd devops-infra
Configure AWS Credentials:
set your AWS credentials in the ~/.aws directory. The script is configured with default values: region=ap-southeast-2 and profile=default.

Export environment variables:
TF_VAR_REGION (example: export TF_VAR_REGION=us-east-2)
TF_VAR_PROFILE (example: export TF_VAR_PROFILE=poc)
TF_VAR_ACCOUNT (example: export TF_VAR_ACCOUNT=123456789012)
Run the Infrastructure Setup Script:
./spinUp.sh
Execute the following script to create the necessary AWS resources using Terraform:

This script will iterate through folders inside the infrastructure directory to set up VPC, Network, EKS, and ECR.



