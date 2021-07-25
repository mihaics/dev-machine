#main disk volume
resource "libvirt_volume" "baseimage" {
  provider = libvirt
  name     = "${var.hostname}-baseimage.qcow2"
  pool     = "default"
  source   = var.cloud_image
  format   = "qcow2"
}

#cloud_init data definitions
data "template_file" "cloud_init" {
  template = file("${path.module}/templates/cloud_init.cfg")
  vars = {
    gitlab_registry_token = var.gitlab_registry_token
    os_user = var.os_user
    root_ssh_key = var.root_ssh_key
    dev_ssh_id = var.dev_ssh_id
  }
}

#cloud_init network definitions
data "template_file" "network_config" {
  template = file("${path.module}/templates/network_config.cfg")
}

#cloud_init metadata definitions
data "template_file" "meta_data" {
  template = file("${path.module}/templates/meta_data.cfg")
  vars = {
    hostname = var.hostname
  }
}

#cloud_init resource disk
resource "libvirt_cloudinit_disk" "commoninit" {
  provider       = libvirt
  name           = "${var.hostname}-commoninit.iso"
  user_data      = data.template_file.cloud_init.rendered
  network_config = data.template_file.network_config.rendered
  meta_data      = data.template_file.meta_data.rendered
  pool           = "default"
}


resource "libvirt_domain" "vm-domain" {
  provider  = libvirt
  name      = var.hostname
  memory    = var.domain_memory
  vcpu      = var.domain_vcpu
  cloudinit = libvirt_cloudinit_disk.commoninit.id
  autostart = true



  network_interface {
    bridge = "br0"  
    hostname = var.hostname
    mac = var.mac_address
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.baseimage.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }


}



