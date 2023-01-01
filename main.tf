# provider "aws" {
#   region  = var.region
#   profile = "myaws"
# }

##------------------------------------------------##
# #CREATING S3 BUCKETS
# resource "aws_s3_bucket" "b" {
#   bucket = var.my-bucket-name
#   acl    = var.acl_name
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }
##------------------------------------------------##

# # CREATING INSTANCE
# resource "aws_instance" "Server1" {
#   #ami                    = var.image_id         # TO USE/GET IMAGE ID STATICALY
#   ami               = "ami-02045ebddb047018b"
#   instance_type     = "t2.micro"
#   availability_zone = "ap-southeast-1c"
# }
##------------------------------------------------##
# #CREATING VPC/VNET
# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
# }

# #CREATING SUBNET AND ASSIGNING IT THE VPC ID
# resource "aws_subnet" "main" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "Main"
#   }
# }

# #CREATING NETWORK INTERFACE
# resource "aws_network_interface" "test" {
#   subnet_id       = aws_subnet.main.id
#   private_ips     = ["10.0.1.11"]
# }

# #CREATING EC2 INSTANCE
# resource "aws_instance" "web" {
#   ami           = "ami-02045ebddb047018b"
#   instance_type = "t2.micro"

#    network_interface {
#     network_interface_id = aws_network_interface.test.id
#     device_index         = 0
#   }
# }
##------------------------------------------------##
# # #CREATING VPC/VNET
# resource "aws_vpc" "main" {
#   cidr_block = "172.16.0.0/16"
# }

# #CREATING SUBNET AND ASSIGNING IT THE VPC ID
# resource "aws_subnet" "main" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "172.16.10.0/24"
#   tags = {
#     Name = "Demo_subnet"
#   }
# }

##------------------------------------------------##
# #CREATING A DATA SOURCE 

# data "aws_subnet" "selected" {
#   id = "subnet-0615b755f07b13aca"
# } 

# #CREATING NETWORK INTERFACE USING THE SUBNET ID FROM THE DATA SOURCE
# resource "aws_network_interface" "test" {
#   subnet_id       = data.aws_subnet.selected.id
#   private_ips     = ["172.16.2.100"]
# }

# #CREATING EC2 INSTANCE
# resource "aws_instance" "web" {
#   ami           = "ami-02045ebddb047018b"
#   instance_type = "t2.micro"
#   tags = {
#     Name = "ec2_demo"
#   }
#    network_interface {
#     network_interface_id = aws_network_interface.test.id
#     device_index         = 0
#   }
# }

##------------------------------------------------##
# variable "vpc_cidr" {
#   default = {
#     dev = "172.16.0.0/16"
#     prod = "172.16.0.0/24"
#   }
# }


# resource "aws_vpc" "main" {
#   for_each = var.vpc_cidr
#   cidr_block = each.value
#   tags = {
#         name = each.key
#   } 
# }
##------------------------------------------------##

# variable "vpcs" {
#   type = map(object({
#     cidr             = string
#     instance_tenancy = string
#     tags             = map(string)
#   }))
#   default = {
#     "1" = {
#       cidr             = "172.16.0.0/16"
#       instance_tenancy = "default"
#       tags = {
#         "name" = "dev"
#         "env"  = "1"
#       }
#     }
#     "2" = {
#       cidr             = "172.16.0.0/24"
#       instance_tenancy = "default"
#       tags = {
#         "name" = "prod"
#         "env"  = "2"
#       }
#     }
#   }
# }

# resource "aws_vpc" "main" {
#   for_each         = var.vpcs
#   cidr_block       = each.value.cidr
#   instance_tenancy = each.value.instance_tenancy
#   tags = each.value["tags"]
# }

#-------------------------------------------------------------CALLING THE MODULES----------------------------------------------------------##

module "vpc" {
  source   = "./modules/aws_vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name

}

module "sg" {
  source  = "./modules/aws_sg"
  vpc_id  = module.vpc.vpc_id
  sg_name = var.sg_name
}

module "subnet" {
  source      = "./modules/aws_subnet"
  vpc_id      = module.vpc.vpc_id
  subnet_cidr = var.subnet_cidr
  subnet_tag  = var.subnet_tag
}

# module "nic" {
#   source      = "./modules/aws_nic"
#   subnet_id   = module.subnet.subnet_id
#   private_ips = var.private_ips
#   nic_name    = var.nic_name
# }

# module "key-pair" {
#   source     = "./modules/aws_key_pair"
#   key_name   = var.key_name
#   public_key = file("${path.module}/id_rsa.pub")
# }

resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf-2"
  public_key = file("${path.module}/id_rsa.pub")
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

module "instance" {
  source = "./modules/aws_instance"
  count  = var.number_of_instances
  # ami_id        = var.ami_id
  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  instance_name = var.instance_name
  key_name      = aws_key_pair.key-tf.key_name
  # nic_id        = module.nic.nic_id
  subnet_id = module.subnet.subnet_id
  sg_id     = module.sg.sg_id
}
