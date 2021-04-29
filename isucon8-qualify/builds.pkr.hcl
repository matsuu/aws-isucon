build {
  sources = ["source.amazon-ebs.ubuntu-amd64"]

  provisioner "shell" {
    script = "ansible.sh"
  }
}
