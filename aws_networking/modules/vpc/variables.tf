variable "cidr_block" {
  type        = string
  description = "IPV4 range for VPC Creation"
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support in the VPC"
  default     = false
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  default     = false
}

variable "subnet_details" {
  type = list(object({
    availability_zone = string
    cidr_block        = string
    is_public         = bool
  }))
  description = "Subnet details which will consist a list of Availablity zone and cidr block"
}

variable "enable_resource_name_dns_a_record_on_launch" {
  type        = bool
  description = "DNS names at the launch of resource in this subnet"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

variable "region" {
  type        = string
  description = "Region where these subnets reside"
  default     = "us-east-1"
}

variable "public_routes" {
  type = list(object({
    cidr_block                 = string
    ipv6_cidr_block            = string
    destination_prefix_list_id = string
    gateway_id                 = string
    vpc_peering_connection_id  = string
    vpc_endpoint_id            = string
    transit_gateway_id         = string
    network_interface_id       = string
    nat_gateway_id             = string
    instance_id                = string
    egress_only_gateway_id     = string
    core_network_arn           = string
  }))
  description = "Map of Ingress rule to apply on default NACL"
  default     = []
}

variable "private_routes" {
  type = list(object({
    cidr_block                 = string
    ipv6_cidr_block            = string
    destination_prefix_list_id = string
    gateway_id                 = string
    vpc_peering_connection_id  = string
    vpc_endpoint_id            = string
    transit_gateway_id         = string
    network_interface_id       = string
    nat_gateway_id             = string
    instance_id                = string
    egress_only_gateway_id     = string
    core_network_arn           = string
  }))
  description = "Map of Ingress rule to apply on default NACL"
  default     = []
}

variable "instance" {
  description = "EC2 instance ID for associating Elastic IP to EC2."
  type        = string
  default     = null
}

variable "network_interface" {
  description = "Network interface ID to associate with."
  type        = string
  default     = null
}

variable "associate_with_private_ip" {
  description = "A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address."
  type        = string
  default     = null
}

variable "public_ipv4_pool" {
  description = "EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs."
  type        = string
  default     = null
}

variable "connectivity_type" {
  type        = string
  description = "Connectivity type for the NAT gateway. Valid values are private and public."
  default     = "public"
}

variable "private_ip" {
  type        = string
  description = " The private IPv4 address to assign to the NAT gateway. If not specified, a private IPv4 address will be automatically assigned"
  default     = null
}
