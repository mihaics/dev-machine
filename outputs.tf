output "network_address" {
  value = [libvirt_domain.vm-domain.network_interface.0.addresses]
}
