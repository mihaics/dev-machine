terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}
