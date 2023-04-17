terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
    }
  }
}

provider "linode" {
  token = var.token
  api_version = "v4beta"
}

resource "linode_instance" "workshop"{
label = "managementInstance"
image = "linode/debian11"
region = "us-southeast"
type = "g6-nanode-1"
root_pass = var.root_pass
private_ip = true
authorized_keys = [linode_sshkey.workshop_key.ssh_key]

  provisioner "file"{
    source = "../scripts/instance.sh"
    destination = "/tmp/instance.sh"
    connection {
      type = "ssh"
      host = self.ip_address
      user = "root"
      password = var.root_pass
    }
  }

  provisioner "remote-exec"{
    inline = [
      "export LINODE_TOKEN=${var.token}",
      "echo ${var.token} >> pat_token.txt",
      "source ~/.bashrc",
      "chmod +x /tmp/instance.sh",
      "/tmp/instance.sh",
      "sleep 1"
    ]
    connection {
      type = "ssh"
      host = self.ip_address
      user = "root"
      password = var.root_pass
    }

  }

}

resource "linode_sshkey" "workshop_key" {
  label = "workshopkey"
  ssh_key = chomp(file("../ssh-keys/workshopK.pub"))
}


variable "token"{}
variable "root_pass"{}