variable "ami_name" {
  type    = string
  default = "isucon8-qualify-{{isotime \"20060102030405\"}}"
}

variable "ami_description" {
  type    = string
  default = ""
}

variable "ami_groups" {
  type    = list(string)
  default = []
}

variable "spot_instance_types" {
  type    = list(string)
  default = ["c4.large", "c5.large", "c5a.large", "c5d.large", "c5n.large", "m4.large", "m5.large", "m5a.large"]
}

# https://wiki.centos.org/Cloud/AWS
variable "source_ami" {
  type = string
  default = "ami-0ddea5e0f69c193a4"
}

variable "volume_size" {
  type    = number
  default = 16
}
