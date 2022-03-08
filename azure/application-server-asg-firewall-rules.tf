
resource "azurerm_network_security_rule" "inbound-allow-ssh-bastion-hosts-asg-to-application-server-asg" {
	name						= "inbound-allow-ssh-bastion-hosts-asg-to-application-server-asg"
	description					= "Allow SSH from Bastion Host ASG to App Server ASG"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "110"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_application_security_group_ids		= ["${azurerm_application_security_group.bastion-hosts-application-security-group.id}"]
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
	destination_port_range				= "${var.ssh-port}"
}

resource "azurerm_network_security_rule" "inbound-allow-icmp-bastion-hosts-asg-to-application-server-asg" {
	name						= "inbound-allow-icmp-bastion-hosts-asg-to-application-server-asg"
	description					= "Allow ICMP Echo (ping) from Bastion Host ASG to App Server ASG"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "111"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Icmp"
	source_application_security_group_ids		= ["${azurerm_application_security_group.bastion-hosts-application-security-group.id}"]
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
	destination_port_range				= "*"
}

resource "azurerm_network_security_rule" "inbound-allow-http-application-gateway-to-application-server-asg" {
	name						= "inbound-allow-http-application-gateway-to-application-server-asg"
	description					= "Allow HTTP from Application Gateway to App Server ASG"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "112"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "TCP"
	source_address_prefix				= "GatewayManager"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
	destination_port_ranges				= ["${var.http-port}","${var.mysql-admin-http-port}","${var.ldap-admin-http-port}","${var.https-port}"]	
}

resource "azurerm_network_security_rule" "inbound-allow-load-balancer-health-probe-to-application-server-asg" {
	name						= "inbound-allow-load-balancer-health-probe-to-application-server-asg"
	description					= "Allow Load Balancer Health Probe to App Server ASG"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "113"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "TCP"
	source_address_prefix				= "${var.azure-load-balancer-health-probe-ip-address}"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
	destination_port_ranges				= ["${var.http-port}","${var.mysql-admin-http-port}","${var.ldap-admin-http-port}","${var.https-port}"]	
}

resource "azurerm_network_security_rule" "inbound-deny-all-to-application-security-group" {
	name						= "inbound-deny-all-to-application-security-group"
	description					= "Deny all from all to application security group"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "4095"
	access						= "Deny"
	direction					= "Inbound"
	protocol					= "*"
	source_address_prefix				= "*"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
	destination_port_range				= "*"
}
