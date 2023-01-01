#------------------------------------------------------NETWORK INTERFACE WITH ATTCHED SUBNET----------------------------------------------------#
resource "aws_network_interface" "test" {
  subnet_id       = var.subnet_id
  private_ips     = var.private_ips

  tags = var.nic_name
}

