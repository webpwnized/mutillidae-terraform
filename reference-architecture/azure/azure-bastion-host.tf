
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host
# https://learn.microsoft.com/en-us/azure/bastion/configuration-settings#instance
# https://learn.microsoft.com/en-us/azure/bastion/connect-ip-address
# https://learn.microsoft.com/en-us/azure/bastion/connect-vm-native-client-linux
# https://learn.microsoft.com/en-us/azure/bastion/bastion-nsg

resource "azurerm_bastion_host" "azurerm-bastion-host" {
	name			= "${var.azure-bastion-host-name}"
	location		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
	sku			= "Basic"
	copy_paste_enabled	= true
	scale_units		= 2	# A "Scale Unit" is an instance of an Azure Bastion Server. scale_units only can be changed when sku is Standard
	file_copy_enabled	= false	# file_copy_enabled is only supported when sku is Standard
	ip_connect_enabled	= false # ip_connect_enabled is only supported when sku is Standard
	shareable_link_enabled	= false # Security risk. Ensure this is false. The Bastion Shareable Link feature lets users connect to a target resource using Azure Bastion without accessing the Azure portal. shareable_link_enabled is only supported when sku is Standard.
	tunneling_enabled	= false # tunneling_enabled is only supported when sku is Standard.

	# Azure Bastion requires a dedicated subnet: AzureBastionSubnet. You must create this subnet in the same virtual network that you want to deploy Azure Bastion to. The subnet must have the following configuration:
	#	Subnet name must be AzureBastionSubnet
	#	Subnet size must be /26 or larger
	#	The subnet must be in the same VNet and resource group as the bastion host
	#	The subnet can't contain other resources.
	ip_configuration {
		name                 = "${var.azure-bastion-host-name}-ip-configuration"
		subnet_id            = "${azurerm_subnet.azure-bastion-host-subnet}"
		public_ip_address_id = "${azurerm_public_ip.azure-bastion-host-public-ip}"
	}
}

output "azure-bastion-host-fqdn" {
	value 		= "${azurerm_public_ip.azurerm-bastion-host.fqdn}"
	description	= "Fully qualified domain name of the A DNS record associated with the bastion host"
}

