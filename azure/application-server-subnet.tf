resource "azurerm_subnet" "application-server-subnet" {
	name			= "${var.project-name}-application-server-subnet"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	virtual_network_name	= "${azurerm_virtual_network.virtual-network.name}"
	
	enforce_private_link_endpoint_network_policies	= true
	enforce_private_link_service_network_policies	= true
	address_prefixes				= ["10.0.2.0/28"]
}
