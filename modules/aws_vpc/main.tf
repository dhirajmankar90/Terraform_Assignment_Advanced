#-------------------------------------------------------------------CREATING VPC/VNET------------------------------------------------------------#
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags       = var.vpc_name
  enable_dns_support = true
}

