variable "region" {
  description = "Enter the AWS region"
  type = string
  default = "us-east-1"
}
# ENter Credentials
/*
variable "access_key" {
  description = "Enter the IAM access key"
  type = string
}

variable "secret_key" {
  description = "Enter IAM Secret Key"
  type = string
}
*/
variable "cidr_vpc" {
  description = "Enter CIDR range"
  default = "192.168.0.0/16"
  type = string
}

variable "public_subnet_cidr" {
  type = list
  default = ["192.168.4.0/24"]
}

variable "private_subnet_cidr" {
  type = list
  default = ["192.168.5.0/24", "192.168.6.0/24"]
}
variable "availability_zone" {
  type = list
  default = ["us-east-1a", "us-east-1b"]
}

variable "tag" {
  type = string
  default = "Dev-cvayutopia"
}