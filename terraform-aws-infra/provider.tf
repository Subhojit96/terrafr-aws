terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">=2.64.0"
    }
  }
}

provider "aws" {
  profile  = "default"
  #access_key = ""
  #secret_key = ""
  region = "${var.region}"
}