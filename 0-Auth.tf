provider "aws" {
  region = "sa-east-1"
}

#Rio 10.153.x.x (use regions a & c, terraform keeps saying region b doesn't have t2.micros)

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "tls"{

}

#--------------------------------------------------------------
provider "aws" {
  alias = "NovaYork"
  region = "us-east-1"
}

#NYC 10.151.x.x (use regions a & b), no NY region so NVA will have to do

provider "aws" {
  alias = "Londres"
  region = "eu-west-2"
}

#London 10.152.x.x (use regions a & b)