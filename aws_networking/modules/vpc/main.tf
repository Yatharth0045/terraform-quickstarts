resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = merge(var.tags, tomap({ "Name" : "my-vpc" }))
}

resource "aws_subnet" "this" {
  count                                       = length(var.subnet_details)
  cidr_block                                  = lookup(var.subnet_details[count.index], "cidr_block", "undefined")
  vpc_id                                      = aws_vpc.this.id
  availability_zone                           = "${var.region}${lookup(var.subnet_details[count.index], "availability_zone", "undefined")}"
  map_public_ip_on_launch                     = lookup(var.subnet_details[count.index], "is_public", false) ? true : false
  enable_resource_name_dns_a_record_on_launch = var.enable_resource_name_dns_a_record_on_launch
  tags                                        = merge(var.tags, tomap({ "Name" : lookup(var.subnet_details[count.index], "is_public", false) ? "my-public-subnet-${lookup(var.subnet_details[count.index], "availability_zone", "undefined")}" : "my-private-subnet-${lookup(var.subnet_details[count.index], "availability_zone", "undefined")}" }))
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, tomap({ "Name" : "my-igw" }))
}

resource "aws_eip" "this" {
  instance                  = var.instance
  network_interface         = var.network_interface
  associate_with_private_ip = var.associate_with_private_ip
  public_ipv4_pool          = var.public_ipv4_pool
  tags                      = merge(var.tags, tomap({ "Name" : "my-nat-eip" }))
}

resource "aws_nat_gateway" "this" {
  allocation_id     = aws_eip.this.id
  subnet_id         = aws_subnet.this[0].id
  private_ip        = var.private_ip
  connectivity_type = var.connectivity_type
  tags              = merge(var.tags, tomap({ "Name" : "my-nat" }))
}

resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  dynamic "route" {
    for_each = var.public_routes
    content {
      cidr_block                = route.value["cidr_block"]
      gateway_id                = route.value["gateway_id"]
      vpc_peering_connection_id = route.value["vpc_peering_connection_id"]
      vpc_endpoint_id           = route.value["vpc_endpoint_id"]
      transit_gateway_id        = route.value["transit_gateway_id"]
      network_interface_id      = route.value["network_interface_id"]
      nat_gateway_id            = route.value["nat_gateway_id"]
      instance_id               = route.value["instance_id"]
      egress_only_gateway_id    = route.value["egress_only_gateway_id"]
      core_network_arn          = route.value["core_network_arn"]
    }
  }

  tags = merge(var.tags, tomap({ "Name" : "my-public-rt" }))
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
  dynamic "route" {
    for_each = var.private_routes
    content {
      cidr_block                = route.value["cidr_block"]
      gateway_id                = route.value["gateway_id"]
      vpc_peering_connection_id = route.value["vpc_peering_connection_id"]
      vpc_endpoint_id           = route.value["vpc_endpoint_id"]
      transit_gateway_id        = route.value["transit_gateway_id"]
      network_interface_id      = route.value["network_interface_id"]
      nat_gateway_id            = route.value["nat_gateway_id"]
      egress_only_gateway_id    = route.value["egress_only_gateway_id"]
      core_network_arn          = route.value["core_network_arn"]
    }
  }

  tags = merge(var.tags, tomap({ "Name" : "my-private-rt" }))
}

resource "aws_route_table_association" "subnets" {
  count          = length(aws_subnet.this)
  route_table_id = aws_subnet.this[count.index].map_public_ip_on_launch ? aws_default_route_table.this.id : aws_route_table.this.id
  subnet_id      = aws_subnet.this[count.index].id
}
