
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule

resource "azurerm_network_security_rule" "inbound-allow-ssh-office-to-bastion-hosts" {
	name						= "inbound-allow-ssh-office-to-bastion-host"
	description					= "Allow SSH to bastion host from office"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "100"
	access						= "Allow"
	direction					= "Inbound"
	protocol					= "Tcp"
	source_address_prefixes				= "${var.admin-office-ip-address-range}"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.bastion-hosts-application-security-group.id}"]
	destination_port_range				= "${var.ssh-port}"
}

resource "azurerm_network_security_rule" "inbound-deny-all-to-bastion-hosts" {
	name						= "inbound-deny-all-to-bastion-hosts-security-group"
	description					= "Deny all from all to bastion hosts security group"
	resource_group_name 				= "${azurerm_resource_group.resource-group.name}"
	network_security_group_name			= "${azurerm_network_security_group.network-security-group.name}"
	priority					= "4096"
	access						= "Deny"
	direction					= "Inbound"
	protocol					= "*"
	source_address_prefix				= "*"
	source_port_range				= "*"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.bastion-hosts-application-security-group.id}"]
	destination_port_range				= "*"
}



