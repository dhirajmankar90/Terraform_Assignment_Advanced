variable "subnet_id" {
  type = string
}

variable "private_ips" {
  type = list(string)
  default = ["172.16.0.100"]
}

variable "nic_name" {
    type = map(any)
    default = {
      "Name" = "primary_network_interface"
    }
}