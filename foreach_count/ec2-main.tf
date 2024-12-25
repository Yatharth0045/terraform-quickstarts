terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ec2_instances" {
  source = "./modules/ec2_instances"
  for_each = toset(var.names)
  instance_type = var.instance_type
  name = each.key
}

variable "names" {
  default = ["ins-1", "ins-2", "ins-3"]
}

variable "instance_type" {
  default = "t2.micro"
}
