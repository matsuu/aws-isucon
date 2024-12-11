source "amazon-ebs" "ubuntu-amd64" {
  ami_name        = var.ami_name
  ami_description = var.ami_description
  ami_groups      = var.ami_groups

  #instance_type = "c5.large"

  spot_instance_types = var.spot_instance_types
  spot_price          = "auto"

  fleet_tags = {
    Name = var.ami_name
  }

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  launch_block_device_mappings {
    volume_type           = "gp3"
    device_name           = "/dev/sda1"
    volume_size           = var.volume_size
    delete_on_termination = true
  }

  ebs_optimized = true

  ssh_username              = "ubuntu"
  ssh_interface             = "public_ip"
  ssh_clear_authorized_keys = true
}
