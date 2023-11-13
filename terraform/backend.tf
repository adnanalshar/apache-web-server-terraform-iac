terraform {
  required_version = ">= 0.14.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.71"
    }
  }
  backend "s3" {
    bucket         = "devops-projects-terraform-state-bucket"
    key            = "state/apache-web-server-terraform-iac/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    kms_key_id     = "alias/terraform_state_bucket_key"
    dynamodb_table = "devops-projects-terraform-state-dynamodb"
  }
}
