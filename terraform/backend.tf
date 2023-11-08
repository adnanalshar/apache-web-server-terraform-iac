terraform {
  required_version = ">= 0.15.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.24.0"
    }
  }
  backend "s3" {
    bucket         = "apache-webserver-terraform-state-bucket"
    key            = "state/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    kms_key_id     = "alias/terraform_state_bucket_key"
    dynamodb_table = "apache-webserver-terraform-state-dynamodb"
  }
}