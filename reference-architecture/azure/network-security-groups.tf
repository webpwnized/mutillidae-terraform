resource "azurerm_network_security_group" "network-security-group" {
	name                	= "${var.project-name}-network-security-group"
	location            	= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
}

