variable "terraform_state_bucket_name" {
  type    = string
  default = "apache-webserver-terraform-state-bucket"
}

variable "terraform_state_dynamo_db_table_name" {
  type    = string
  default = "apache-webserver-terraform-state-dynamodb"
}