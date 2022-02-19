resource "azurerm_subnet" "application-gateway-subnet" {
	name			= "${var.project-name}-application-gateway-subnet"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	virtual_network_name	= "${azurerm_virtual_network.virtual-network.name}"
	
	enforce_private_link_endpoint_network_policies	= true
	enforce_private_link_service_network_policies	= true
	address_prefixes				= ["10.0.3.0/28"]
}

output "application-gateway-subnet-id" {
	value		= "${azurerm_subnet.application-gateway-subnet.id}"
	description	= "The name of the subnet"
}

output "application-gateway-subnet-address-prefixes" {
	value 		= "${jsonencode(azurerm_subnet.application-gateway-subnet.address_prefixes)}"
	description	= "The address prefixes for the subnet"
}

