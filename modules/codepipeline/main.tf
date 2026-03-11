resource "aws_codepipeline" "pipeline" {
  name     = "My-CICD-Pipeline"
  role_arn = var.pipeline_role_arn

  artifact_store {
    type     = "S3"
    location = var.artifact_bucket
  }

#################################
# SOURCE STAGE
#################################

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"

      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = var.connection_arn
        FullRepositoryId = var.repo_name
        BranchName       = var.branch_name
      }
    }
  }

#################################
# BUILD STAGE
#################################

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"

      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

#################################
# DEPLOY STAGE
#################################

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"

      input_artifacts = ["BuildArtifact"]

      configuration = {
        ApplicationName     = var.codedeploy_app_name
        DeploymentGroupName = var.codedeploy_group_name
      }
    }
  }
}