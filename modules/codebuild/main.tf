resource "aws_codebuild_project" "build_project" {

  name         = var.project_name
  service_role = var.codebuild_role_arn
  build_timeout = 10

  source {
    type            = "GITHUB"
    location        = var.github_repo_url
    git_clone_depth = 1
    buildspec       = "buildspec.yml"
  }

  environment {
  compute_type                = "BUILD_GENERAL1_SMALL"
  type                        = "LINUX_CONTAINER"
  image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
  image_pull_credentials_type = "CODEBUILD"
  privileged_mode             = false
}

  artifacts {
    type      = "S3"
    location  = var.artifact_bucket
    packaging = "ZIP"
    name      = "build-output"
    path      = "codebuild-artifacts"
  }

  logs_config {
  cloudwatch_logs {
    status = "ENABLED"
  }

  s3_logs {
    status   = "ENABLED"
    location = "akshata-cicd-artifacts-2026/codebuild-logs"
  }
}

  tags = {
    Name = var.project_name
  }
}