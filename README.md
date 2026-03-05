# AWS CI/CD Terraform Project

## Overview
This project provisions a complete CI/CD pipeline on AWS using Terraform. It automates infrastructure setup and deployment for applications hosted on EC2, integrating with GitHub, CodeBuild, CodeDeploy, and CodePipeline.

## Features
- Modular Terraform code for maintainability
- Secure IAM roles and policies
- S3 bucket for build artifacts (versioned, public access blocked)
- EC2 instance with Apache and CodeDeploy agent
- CodeBuild project for building from GitHub
- CodeDeploy for automated deployments
- CodePipeline for end-to-end automation

## Prerequisites
- AWS account and credentials
- Terraform installed
- GitHub repository for your application

## Setup Instructions
1. Clone this repository.
2. Update `terraform.tfvars` with your values (bucket name, key name, ARNs, etc.).
3. Run the following commands:
   ```
   terraform init
   terraform plan
   terraform apply
   ```
4. Confirm resources are created in your AWS account.

## Module Structure
- `modules/iam`: IAM roles and instance profiles
- `modules/s3`: S3 bucket for artifacts
- `modules/ec2`: EC2 instance and security group
- `modules/codebuild`: CodeBuild project
- `modules/codedeploy`: CodeDeploy application and deployment group
- `modules/codepipeline`: CodePipeline definition

## Usage
- Push code to your GitHub repository to trigger the pipeline.
- CodePipeline will build, test, and deploy your application to EC2 automatically.

## Security
- IAM roles are scoped to least privilege
- S3 buckets block public access
- EC2 security groups restrict traffic

## Support
For questions or issues, contact the project maintainer.
