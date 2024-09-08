output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC id"
}

output "subnet_ids" {
  value = {
    for index, subnet in aws_subnet.this : subnet.tags["Name"] => subnet.id
  }
  description = "Subnet Az and their corresponding Ids"
}

output "subnet_ids_block" {
  value = aws_subnet.this
}

# output "vpc_info" {
#   value       = aws_vpc.this
#   description = "VPC id"
# }
# output "owner_id" {
#   value       = aws_vpc.this.owner_id
#   description = "Owner ID of this VPC"
# }
# output "nacl_id" {
#   value       = aws_vpc.this.default_network_acl_id
#   description = "Default Nacl ID of this VPC"
# }

# output "default_rid" {
#   value       = aws_vpc.this.default_route_table_id
#   description = "Default Route Table ID of this VPC"
# }

# output "main_rid" {
#   value       = aws_vpc.this.main_route_table_id
#   description = "Main Route table ID of this VPC"
# }
