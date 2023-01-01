variable "vpc_id" {
  type = string
}

variable "subnet_cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "subnet_tag" {
    type = map(any)
    default = {
        Name = "tf-subnet-example"
    }
}