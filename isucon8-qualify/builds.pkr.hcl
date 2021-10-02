build {
  sources = ["source.amazon-ebs.ubuntu-amd64"]

  provisioner "shell" {
    inline = ["/usr/bin/cloud-init status --wait"]
  }

  provisioner "shell" {
    script = "ansible.sh"
  }
}
