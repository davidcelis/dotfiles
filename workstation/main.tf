provider "digitalocean" {}

resource "digitalocean_droplet" "tomato" {
  ssh_keys           = [24195986]
  image              = "ubuntu-19-04-x64"
  region             = "sfo2"
  size               = "s-4vcpu-8gb"
  private_networking = true
  backups            = true
  ipv6               = true
  name               = "tomato"

  provisioner "remote-exec" {
    script = "scripts/bootstrap"

    connection {
      type        = "ssh"
      private_key = "${file("~/.ssh/ipad_ed25519")}"
      user        = "root"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "scripts/pull-secrets"
    destination = "/mnt/secrets/pull-secrets"

    connection {
      type        = "ssh"
      private_key = "${file("~/.ssh/ipad_ed25519")}"
      user        = "root"
      timeout     = "2m"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /mnt/secrets/pull-secrets",
    ]

    connection {
      type        = "ssh"
      private_key = "${file("~/.ssh/ipad_ed25519")}"
      user        = "root"
      timeout     = "2m"
    }
  }
}

resource "digitalocean_firewall" "tomato" {
  name = "tomato"

  droplet_ids = ["${digitalocean_droplet.tomato.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "3222"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "udp"
      port_range       = "60000-60010"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}

output "public_ip" {
  value = "${digitalocean_droplet.tomato.ipv4_address}"
}
