
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface

# These addresses cannot be used
#	10.0.0.0: Network address.
#	10.0.0.1: Reserved by AWS for the VPC router.
#	10.0.0.2: Reserved by AWS.
#	10.0.0.3: Reserved by AWS for future use.
#	10.0.0.255: Network broadcast address. We do not support broadcast in a VPC, therefore we reserve this address.

locals {
	bastion-host-network-interface-name	= "bastion-host-network-interface"
}

resource "aws_network_interface" "bastion-host-network-interface" {

	subnet_id       = aws_subnet.bastion-host-subnet.id
	private_ips     = ["${var.bastion-host-ip-address}"]
	security_groups = ["${aws_security_group.bastion-host-security-group.id}"]
	description	= "${local.bastion-host-network-interface-name}"

	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.bastion-host-network-interface-name}"
		Purpose = "${local.bastion-host-network-interface-name}"
	}
}

output "bastion-host-network-interface-mac-address" {
	value		= "${aws_network_interface.bastion-host-network-interface.mac_address}"
	description	= "MAC address of the network interface"
	sensitive	= "false"
}

output "bastion-host-network-interface-private-dns-name" {
	value		= "${aws_network_interface.bastion-host-network-interface.private_dns_name}"
	description	= "Private DNS name of the network interface (IPv4)"
	sensitive	= "false"
}

