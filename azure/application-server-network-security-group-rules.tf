resource "azurerm_network_security_rule" "inbound-deny-all-to-application-security-group" {
	name						= "inbound-deny-all-to-application-security-group"
	description					= "Deny all from all to application security group"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "4095"
	access						= "Deny"
	direction					= "Inbound"
	protocol					= "*"
	source_port_range				= "*"
	destination_port_range				= "*"
	source_address_prefix				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
}

resource "azurerm_network_security_rule" "inbound-allow-ssh-bastion-hosts-asg-to-application-server-asg" {
	name						= "inbound-allow-ssh-bastion-hosts-asg-to-application-server-asg"
	description					= "Allow SSH from Bastion Host ASG to App Server ASG"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "101"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_port_range				= "*"
	destination_port_range				= "${var.ssh-port}"
	source_application_security_group_ids		= ["${azurerm_application_security_group.bastion-hosts-application-security-group.id}"]
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
}

resource "azurerm_network_security_rule" "inbound-allow-icmp-bastion-hosts-asg-to-application-server-asg" {
	name						= "inbound-allow-icmp-bastion-hosts-asg-to-application-server-asg"
	description					= "Allow ICMP Echo (ping) from Bastion Host ASG to App Server ASG"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "102"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Icmp"
	source_port_range				= "*"
	destination_port_range				= "*"
	source_application_security_group_ids		= ["${azurerm_application_security_group.bastion-hosts-application-security-group.id}"]
	destination_application_security_group_ids	= ["${azurerm_application_security_group.application-servers-application-security-group.id}"]
}
