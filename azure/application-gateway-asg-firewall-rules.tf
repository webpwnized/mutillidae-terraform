
# https://docs.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure

resource "azurerm_network_security_rule" "inbound-allow-http-to-application-gateways" {
	name						= "inbound-allow-http-to-application-gateways"
	description					= "Allow HTTP from Internet to Application Gateways"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "120"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefix				= "Internet"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-gateway-application-security-group.id}"]
	destination_port_range				= "${var.http-port}"
}

resource "azurerm_network_security_rule" "inbound-allow-gateway-manager-to-all" {
	name						= "inbound-allow-gateway-manager-to-all"
	description					= "Allow incoming requests GatewayManager service tag to all"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "121"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefix				= "GatewayManager"
	source_port_range				= "*"
	destination_address_prefix			= "*"
	destination_port_range				= "${var.azure-gateway-manager-port-range}"
}

resource "azurerm_network_security_rule" "inbound-allow-azure-load-balancer-to-application-gateways" {
	name						= "inbound-allow-azure-load-balancer-to-application-gateways"
	description					= "Allow incoming Azure Load Balancer probes (AzureLoadBalancer tag) on the network security group"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "122"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefix				= "AzureLoadBalancer"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-gateway-application-security-group.id}"]
	destination_port_range				= "*"
}

resource "azurerm_network_security_rule" "inbound-allow-virtual-network-to-application-gateways" {
	name						= "inbound-allow-virtual-network-to-application-gateways"
	description					= "Allow inbound virtual network traffic (VirtualNetwork tag) on the network security group"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "123"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefix				= "VirtualNetwork"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-gateway-application-security-group.id}"]
	destination_port_range				= "*"
}

resource "azurerm_network_security_rule" "outbound-allow-all-from-application-gateways-to-internet" {
	name						= "outbound-allow-all-from-application-gateways-to-internet"
	description					= "Allow outbound traffic to the Internet for all destinations"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "124"
	access						= "Allow"
	direction					= "Outbound"
	protocol					= "Tcp"
	source_application_security_group_ids	= ["${azurerm_application_security_group.application-gateway-application-security-group.id}"]
	source_port_range				= "*"
	destination_address_prefix			= "Internet"
	destination_port_range				= "*"
}

resource "azurerm_network_security_rule" "inbound-deny-all-to-application-gateways" {
	name						= "inbound-deny-all-to-application-gateways"
	description					= "Block all other incoming traffic by using a deny-all rule"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "4094"
	access						= "Deny"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefix				= "*"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-gateway-application-security-group.id}"]
	destination_port_range				= "*"
}








