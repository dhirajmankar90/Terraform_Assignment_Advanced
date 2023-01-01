# variable "my-bucket-name" {
#   type        = string
#   description = "This is for the bucket name"
#   default     = "my-tf-test-bucket12101990"
# }

# variable "acl_name" {
#   type        = string
#   description = "This is the acl name for your bucket"
#   default     = "private"
# }

# variable "region" {
#   type        = string
#   default     = "ap-southeast-1"
#   description = "This is the region name for your bucket"
# }


#----------------------------------------------VARIABLES FOR THE MAIN.TF WHICH WILL BE FED TO MODILES VARIABLES FILES---------------------------#

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  type = map(any)
  default = {
    Name = "tf-example-vpc"
  }
}


variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}
variable "subnet_tag" {
  type = map(any)
  default = {
    Name = "tf-example-subnet"
  }
}


variable "sg_name" {
  type = map(any)
  default = {
    Name = "new_allow_tls"
  }
}

# variable "private_ips" {
#   type    = list(string)
#   default = ["172.16.0.100"]
# }
# variable "nic_name" {
#   type = map(any)
#   default = {
#     "Name" = "primary_network_interface"
#   }
# }


# variable "ami_id" {
#   type    = string
#   default = "ami-02045ebddb047018b"
# }
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_name" {
  type = map(any)
  default = {
    "Name" = "ec2_demo"
  }
}

variable "number_of_instances" {
  type = number
}

