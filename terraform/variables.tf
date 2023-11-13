variable "vpc_name" {
  type    = string
  default = "main_vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_azs" {
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "vpc_private_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "vpc_public_subnets" {
  default = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  default = "~/.ssh/id_rsa"
}