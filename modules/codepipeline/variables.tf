variable "pipeline_name" {
  description = "Name of CodePipeline"
  type        = string
  default     = "My-CICD-Pipeline"
}

variable "pipeline_role_arn" {
  description = "CodePipeline IAM role ARN"
  type        = string
  default     = "arn:aws:iam::203848753188:role/CodePipeline-Service-Role"
}

variable "artifact_bucket" {
  description = "S3 bucket for pipeline artifacts"
  type        = string
  default     = "akshata-cicd-artifacts-2006"
}

variable "connection_arn" {
  description = "GitHub CodeStar connection ARN"
  type        = string
  default     = "arn:aws:codeconnections:us-east-1:203848753188:connection/5b094789-a7a6-4e1d-95ac-f4b871b40243"
}

variable "repo_name" {
  description = "GitHub repository"
  type        = string
  default     = "akshataujawane/aws-cicd-pipeline-project"
}

variable "branch_name" {
  description = "GitHub branch"
  type        = string
  default     = "demo"
}

variable "codebuild_project_name" {
  description = "CodeBuild project name"
  type        = string
  default     = "My-CodeBuild-Project"
}

variable "codedeploy_app_name" {
  description = "CodeDeploy application name"
  type        = string
  default     = "My-CodeDeploy-App"
}

variable "codedeploy_group_name" {
  description = "CodeDeploy deployment group"
  type        = string
  default     = "My-Deployment-Group"
}