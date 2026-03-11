############################################
# 1️⃣ EC2 ROLE (CodeDeploy + S3 + SSM)
############################################

resource "aws_iam_role" "ec2_role" {
  name = "EC2-CodeDeploy-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "ec2_codedeploy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

############################################
# 2️⃣ CODEDEPLOY ROLE
############################################

resource "aws_iam_role" "codedeploy_role" {
  name = "CodeDeploy-Service-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

############################################
# 3️⃣ CODEBUILD ROLE
############################################

resource "aws_iam_role" "codebuild_role" {
  name = "CodeBuild-Service-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

resource "aws_iam_role_policy_attachment" "codebuild_s3_access" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

############################################
# 4️⃣ CODEPIPELINE ROLE
############################################

resource "aws_iam_role" "pipeline_role" {
  name = "CodePipeline-Service-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "pipeline_attach" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

resource "aws_iam_role_policy_attachment" "pipeline_s3_access" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

############################################
# 5️⃣ CODECONNECTION PERMISSION (GitHub)
############################################

resource "aws_iam_policy" "pipeline_connection_policy" {
  name = "CodePipeline-CodeConnections-Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "codeconnections:UseConnection",
        "codestar-connections:UseConnection"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "pipeline_connection_attach" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = aws_iam_policy.pipeline_connection_policy.arn
}

############################################
# 6️⃣ CODEPIPELINE → CODEBUILD PERMISSION
############################################

resource "aws_iam_policy" "pipeline_codebuild_policy" {

  name = "CodePipeline-CodeBuild-Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "codebuild:StartBuild",
        "codebuild:BatchGetBuilds"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "pipeline_codebuild_attach" {

  role       = aws_iam_role.pipeline_role.name
  policy_arn = aws_iam_policy.pipeline_codebuild_policy.arn
}

############################################
# 7️⃣ CODEPIPELINE → CODEDEPLOY PERMISSION
############################################

resource "aws_iam_policy" "pipeline_codedeploy_policy" {

  name = "CodePipeline-CodeDeploy-Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "codedeploy:CreateDeployment",
        "codedeploy:GetApplication",
        "codedeploy:GetApplicationRevision",
        "codedeploy:GetDeployment",
        "codedeploy:GetDeploymentConfig",
        "codedeploy:RegisterApplicationRevision"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "pipeline_codedeploy_attach" {

  role       = aws_iam_role.pipeline_role.name
  policy_arn = aws_iam_policy.pipeline_codedeploy_policy.arn
}

############################################
# 8️⃣ CODEBUILD CLOUDWATCH LOGS PERMISSION
############################################

resource "aws_iam_policy" "codebuild_logs_policy" {

  name = "CodeBuild-CloudWatch-Logs-Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_logs_attach" {

  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_logs_policy.arn
}