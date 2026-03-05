# AWS CI/CD Terraform Project Report

## Project Purpose
This project automates the deployment of a CI/CD pipeline on AWS using Terraform. It enables continuous integration and delivery for applications hosted on EC2, with source code managed in GitHub and deployment orchestrated via AWS services.

## Architecture Summary
- **IAM**: Provides secure roles and policies for EC2, CodeDeploy, CodeBuild, and CodePipeline.
- **S3**: Stores build artifacts with versioning and public access blocked.
- **EC2**: Hosts the application, configured for CodeDeploy and Apache web server.
- **CodeBuild**: Builds code from GitHub and stores outputs in S3.
- **CodeDeploy**: Automates deployment to EC2 instances.
- **CodePipeline**: Connects source, build, and deploy stages for end-to-end automation.

## Key Modules & Resources
- **IAM Module**: Creates roles and instance profiles for all pipeline components.
- **S3 Module**: Provisions an artifact bucket with security best practices.
- **EC2 Module**: Deploys an Ubuntu server with Apache and CodeDeploy agent.
- **CodeBuild Module**: Configures build project, source, environment, artifacts, and logging.
- **CodeDeploy Module**: Sets up application and deployment group with rollback on failure.
- **CodePipeline Module**: Defines pipeline stages and artifact flow.

## Security Practices
- IAM roles are scoped to least privilege.
- S3 buckets block public access.
- EC2 security groups restrict traffic to SSH, HTTP, and HTTPS.

## Automation Features
- CodePipeline automates the workflow from code commit to deployment.
- CodeDeploy supports automatic rollback on deployment failure.

## Customization
- Variables allow easy changes to resource names, ARNs, and configuration.

## Usage Instructions
1. Configure AWS credentials.
2. Update `terraform.tfvars` with your values.
3. Run `terraform init`, `terraform plan`, and `terraform apply`.

## Conclusion
This project provides a robust, secure, and automated CI/CD pipeline on AWS, following best practices for infrastructure-as-code and cloud security.
