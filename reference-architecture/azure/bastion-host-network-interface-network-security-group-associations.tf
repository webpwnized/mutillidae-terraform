resource "azurerm_network_interface_security_group_association" "bastion-host-network-interface" {
	network_interface_id      = azurerm_network_interface.bastion-host-network-interface-1.id
	network_security_group_id = azurerm_network_security_group.network-security-group.id
}
