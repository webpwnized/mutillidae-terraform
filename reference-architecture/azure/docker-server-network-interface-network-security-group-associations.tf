
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_application_security_group_association

resource "azurerm_network_interface_security_group_association" "docker-server-network-interface" {
	network_interface_id      = azurerm_network_interface.docker-server-network-interface-1.id
	network_security_group_id = azurerm_network_security_group.network-security-group.id
}

