variable "app_name" {
  description = "Name of the CodeDeploy application"
  type        = string
  default     = "My-CodeDeploy-App"
}

variable "deployment_group_name" {
  description = "Name of the CodeDeploy deployment group"
  type        = string
  default     = "My-Deployment-Group"
}

variable "codedeploy_role_arn" {
  description = "IAM role ARN for CodeDeploy"
  type        = string
  default     = "arn:aws:iam::203848753188:role/CodeDeploy-Service-Role"
}

variable "ec2_tag_name" {
  description = "EC2 tag name to identify instances for deployment"
  type        = string
  default     = "Terraform-Test-Demo"
}