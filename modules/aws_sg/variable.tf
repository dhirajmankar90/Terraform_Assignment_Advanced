variable "sg_name" {
  type = map(any)
  default = {
    Name = "new_allow_tls"
  }
}

variable "vpc_id" {
  type = string
}
