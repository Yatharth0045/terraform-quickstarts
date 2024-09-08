module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  subnet_details = [
    {
      is_public         = true
      availability_zone = "a"
      cidr_block        = "10.0.0.0/18"
    },
    {
      is_public         = true
      availability_zone = "b"
      cidr_block        = "10.0.64.0/18"
    },
    {
      is_public         = false
      availability_zone = "a"
      cidr_block        = "10.0.128.0/18"
    },
    {
      is_public         = false
      availability_zone = "b"
      cidr_block        = "10.0.192.0/18"
    }
  ]
  tags = local.tags
}

module "ec2" {
  source    = "./modules/ec2"
  subnet_id = module.vpc.subnet_ids.my-public-subnet-a
  tags      = local.tags
}
