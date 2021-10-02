variable "ami_name" {
  type    = string
  default = "isucon11-qualify-{{isotime \"20060102030405\"}}"
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
  default = ["c3.large", "c4.large", "c5.large", "c5a.large", "c5d.large", "c5n.large", "m1.large", "m3.large", "m4.large", "m5.large", "m5a.large", "m5n.large", "m5zn.large", "m6i.large"]
}

variable "volume_size" {
  type    = number
  default = 16
}
