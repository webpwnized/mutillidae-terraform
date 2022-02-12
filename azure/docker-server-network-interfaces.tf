locals {
	docker-server-nic-name	= "docker-server-network-interface-1"
}

resource "azurerm_network_interface" "docker-server-network-interface-1" {
	name                		= "${local.docker-server-nic-name}"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	enable_ip_forwarding		= false
	enable_accelerated_networking	= false
	internal_dns_name_label		= "${local.docker-server-name}"
	tags				= "${var.default-tags}"
	
	ip_configuration {
		name                          	= "${local.docker-server-nic-name}-ip-configuration"
		subnet_id                     	= azurerm_subnet.application-server-subnet.id
		private_ip_address_allocation 	= "Static"
		private_ip_address_version	= "IPv4"
		primary				= true
		private_ip_address		= "10.0.2.5"
	}
}

output "docker-server-dns-server" {
	value 		= "${jsonencode(azurerm_network_interface.docker-server-network-interface-1.applied_dns_servers)}"
	description	= "The union of all DNS servers from all Network Interfaces"
}

output "docker-server-nic-internal-domain-name-suffix" {
	value 		= "${azurerm_network_interface.docker-server-network-interface-1.internal_domain_name_suffix}"
	description	= "The value of internal_domain_name_suffix"
}

output "docker-server-nic-mac-address" {
	value 		= "${azurerm_network_interface.docker-server-network-interface-1.mac_address}"
	description	= "The Media Access Control (MAC) Address of the Network Interface"
}

output "docker-server-nic-private-ip-address" {
	value 		= "${azurerm_network_interface.docker-server-network-interface-1.private_ip_address}"
	description	= "The first private IP address of the network interface"
}

