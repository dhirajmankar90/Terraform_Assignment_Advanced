#-------------------------------------------------------------CREATING EC2 INSTANCE-------------------------------------------------------------#
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = ["${var.sg_id}"]
  tags                        = var.instance_name
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = true
  # source_dest_check           = true

  # network_interface {
  #   network_interface_id = var.nic_id
  #   device_index         = 0
  # }
}

