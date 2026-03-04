############################################
# CODEDEPLOY APPLICATION
############################################

resource "aws_codedeploy_app" "app" {
  name = var.app_name
  compute_platform = "Server"
}

############################################
# CODEDEPLOY DEPLOYMENT GROUP
############################################

resource "aws_codedeploy_deployment_group" "deployment_group" {

  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = var.deployment_group_name
  service_role_arn      = var.codedeploy_role_arn

  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = var.ec2_tag_name
    }
  }

  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}