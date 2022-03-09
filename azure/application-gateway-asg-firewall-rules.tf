
# https://docs.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure

resource "azurerm_network_security_rule" "inbound-allow-http-to-application-gateway" {
	name						= "inbound-allow-http-to-application-gateway"
	description					= "Allow incoming HTTP to Application Gateway"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "121"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefix				= "Internet"
	source_port_range				= "*"
	destination_address_prefix			= "${var.application-gateway-subnet-range}"
	destination_port_range				= "${var.http-port}"
}

resource "azurerm_network_security_rule" "inbound-allow-gateway-manager-to-all" {
	name						= "inbound-allow-gateway-manager-to-all"
	description					= "Allow incoming requests GatewayManager service tag to all"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "122"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefix				= "GatewayManager"
	source_port_range				= "*"
	destination_address_prefix			= "*"
	destination_port_range				= "${var.azure-gateway-manager-port-range}"
}

resource "azurerm_network_security_rule" "inbound-allow-virtual-network-to-application-gateways" {
	name						= "inbound-allow-virtual-network-to-application-gateways"
	description					= "Allow inbound virtual network traffic (VirtualNetwork tag) on the network security group"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "124"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefix				= "${var.application-gateway-subnet-range}"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
	destination_port_ranges				= ["${var.http-port}","${var.mysql-admin-http-port}","${var.ldap-admin-http-port}","${var.https-port}"]
}


