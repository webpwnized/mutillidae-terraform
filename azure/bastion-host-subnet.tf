resource "azurerm_subnet" "bastion-host-subnet" {
	name			= "${var.project-name}-bastion-host-subnet"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	virtual_network_name	= "${azurerm_virtual_network.virtual-network.name}"
	
	enforce_private_link_endpoint_network_policies	= true
	enforce_private_link_service_network_policies	= true
	address_prefixes				= ["10.0.1.0/28"]
}

output "bastion-host-subnet-address-prefixes" {
	value 		= "${jsonencode(azurerm_subnet.bastion-host-subnet.address_prefixes)}"
	description	= "The address prefixes for the subnet"
}

