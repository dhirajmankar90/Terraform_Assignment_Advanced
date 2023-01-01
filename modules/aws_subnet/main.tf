#-------------------------------------------------------SUBNET AND ASSIGNING IT THE VPC ID-----------------------------------------------#
resource "aws_subnet" "mysubnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr

  tags = var.subnet_tag
}

