# #################################
# # IAM MODULE
# #################################

# module "iam" {
#   source = "./modules/iam"
# }

# #################################
# # S3 MODULE
# #################################

# module "s3" {
#   source      = "./modules/s3"
#   bucket_name = var.bucket_name
# }

# #################################
# # EC2 MODULE
# #################################

  
# module "ec2" {
#   source               = "./modules/ec2"
#   ec2_instance_profile = module.iam.ec2_instance_profile
#   key_name             = var.key_name
# }

#################################
# CODEBUILD MODULE
#################################

module "codebuild" {
  source = "./modules/codebuild"

  project_name       = "My-CodeBuild-Project"
  github_repo_url    = "https://github.com/akshataujawane/aws-cicd-pipeline-project.git"
  artifact_bucket    = "akshata-cicd-artifacts-2026"
  codebuild_role_arn = "arn:aws:iam::203848753188:role/CodeBuild-Service-Role"
}

#################################
# CODEDEPLOY MODULE
#################################

module "codedeploy" {
  source = "./modules/codedeploy"

  app_name              = "My-CodeDeploy-App"
  deployment_group_name = "My-Deployment-Group"
  codedeploy_role_arn   = "arn:aws:iam::203848753188:role/CodeDeploy-Service-Role"
  ec2_tag_name          = "Terraform-Test-Demo"
}