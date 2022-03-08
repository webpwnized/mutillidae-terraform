
resource "azurerm_subnet_network_security_group_association" "application-gateway-subnet" {
	subnet_id                 	= "${azurerm_subnet.application-gateway-subnet.id}"
	network_security_group_id	= "${azurerm_network_security_group.network-security-group.id}"
}

resource "azurerm_subnet_network_security_group_association" "application-server-subnet" {
	subnet_id                 	= "${azurerm_subnet.application-server-subnet.id}"
	network_security_group_id	= "${azurerm_network_security_group.network-security-group.id}"
}

resource "azurerm_subnet_network_security_group_association" "bastion-host-subnet" {
	subnet_id                 	= "${azurerm_subnet.bastion-host-subnet.id}"
	network_security_group_id	= "${azurerm_network_security_group.network-security-group.id}"
}


