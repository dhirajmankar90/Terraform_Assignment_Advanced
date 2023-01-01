
variable "ami_id" {
  type    = string
  default = "ami-02045ebddb047018b"
}
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
# }
# variable "nic_id" {
#   type = string
# }

variable "sg_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}