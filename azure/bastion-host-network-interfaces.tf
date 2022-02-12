locals {
	bastion-host-nic-name	= "bastion-host-network-interface-1"
}

resource "azurerm_network_interface" "bastion-host-network-interface-1" {
	name                		= "${local.bastion-host-nic-name}"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	enable_ip_forwarding		= false
	enable_accelerated_networking	= false
	internal_dns_name_label		= "${local.bastion-host-name}"
	tags				= "${var.default-tags}"
	
	ip_configuration {
		name                          	= "${local.bastion-host-nic-name}-ip-configuration"
		subnet_id                     	= "${azurerm_subnet.bastion-host-subnet.id}"
		private_ip_address_allocation 	= "Static"
		private_ip_address_version	= "IPv4"
		primary				= true
		private_ip_address		= "10.0.1.5"
		public_ip_address_id		= "${azurerm_public_ip.bastion-host-public-ip.id}"
	}
}

output "bastion-host-dns-server" {
	value 		= "${jsonencode(azurerm_network_interface.bastion-host-network-interface-1.applied_dns_servers)}"
	description	= "The union of all DNS servers from all Network Interfaces"
}

output "bastion-host-nic-internal-domain-name-suffix" {
	value 		= "${azurerm_network_interface.bastion-host-network-interface-1.internal_domain_name_suffix}"
	description	= "The value of internal_domain_name_suffix"
}

output "bastion-host-nic-mac-address" {
	value 		= "${azurerm_network_interface.bastion-host-network-interface-1.mac_address}"
	description	= "The Media Access Control (MAC) Address of the Network Interface"
}

output "bastion-host-nic-private-ip-address" {
	value 		= "${azurerm_network_interface.bastion-host-network-interface-1.private_ip_address}"
	description	= "The first private IP address of the network interface"
}

