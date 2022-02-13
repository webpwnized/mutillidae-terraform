resource "azurerm_network_interface_application_security_group_association" "bastion-hosts" {
	network_interface_id          = azurerm_network_interface.bastion-host-network-interface-1.id
	application_security_group_id = azurerm_application_security_group.bastion-hosts-application-security-group.id
}

resource "azurerm_network_interface_application_security_group_association" "application-servers" {
	network_interface_id          = azurerm_network_interface.docker-server-network-interface-1.id
	application_security_group_id = azurerm_application_security_group.application-servers-application-security-group.id
}

