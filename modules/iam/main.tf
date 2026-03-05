############################################
# 1️⃣ EC2 ROLE (EC2 + CodeDeploy + S3 + SSM)
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

# Allow EC2 to communicate with AWS Systems Manager
resource "aws_iam_role_policy_attachment" "ec2_ssm_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Allow EC2 to download deployment bundle from S3
resource "aws_iam_role_policy_attachment" "ec2_s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Required for CodeDeploy agent on EC2
resource "aws_iam_role_policy_attachment" "ec2_codedeploy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

# Instance profile for EC2
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

# CodeBuild full access for building projects
resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# Access to artifact bucket
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

# Allow pipeline to interact with all services
resource "aws_iam_role_policy_attachment" "pipeline_attach" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

# Allow pipeline to access artifacts in S3
resource "aws_iam_role_policy_attachment" "pipeline_s3_access" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}