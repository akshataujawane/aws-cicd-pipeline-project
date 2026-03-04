terraform {
  backend "s3" {
    bucket  = "akshata-terraform-state-2026"
    key     = "cicd/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}


