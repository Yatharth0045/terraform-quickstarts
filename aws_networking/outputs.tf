output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "public_ip" {
  value = module.ec2.instance_ip_public
}

output "private_ip" {
  value = module.ec2.instance_ip_private
}
