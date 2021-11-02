#Local provider related variables

variable "qemu_uri" {
  description = "URI to connect with the qemu-service."
  default = "qemu:///system"
}

variable "domain_memory" {
  default = "8192"
}

variable "domain_vcpu" {
  default = "4"
}

variable "cloud_image" {
  description = "Image Source"
  default = "https://cloud-images.ubuntu.com/hirsute/current/hirsute-server-cloudimg-amd64.img"
}


variable "mac_address" {
  description = "assign this mac to interface"
  default = "AA:BB:CC:11:24:24"
}

variable "hostname" {
  description = "host name"
  default = "devmachine"
}


variable "network" {
  description = "Name of Libvirt Network"
  default = "default"
}


variable "os_codename" {
  description = "OS codename"
  default     = "groovy"
}

#variable "docker-auth-token" {}

variable "os_user" {
  description = "default user for login"
  default = "bitwarpers"
}

variable "gitlab_registry_token" {
  description = "acess to gitlab in base64 format"
  default = ""
}

variable "root_ssh_key" {
  description = "Public key which will be added to .ssh/authorized_keys for root user"
  default = ""
}

variable "dev_ssh_id" {
  description = "id used to import ssh keys for developer access, github or other"
  default = ""
}
