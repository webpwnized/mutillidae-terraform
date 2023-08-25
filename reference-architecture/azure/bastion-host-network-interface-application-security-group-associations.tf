
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_application_security_group_association

resource "azurerm_network_interface_application_security_group_association" "bastion-host" {
	network_interface_id          = "${azurerm_network_interface.bastion-host-network-interface-1.id}"
	application_security_group_id = "${azurerm_application_security_group.bastion-hosts-application-security-group.id}"
}

