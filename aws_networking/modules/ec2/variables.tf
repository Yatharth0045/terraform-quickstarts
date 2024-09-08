variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet id where ec2 needs to be launched"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}
