
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

resource "aws_subnet" "bastion-host-subnetwork" {
	vpc_id				= "${aws_vpc.mutillidae-vpc.id}"
	assign_ipv6_address_on_creation	= "false"
	availability_zone 		= "${var.availability-zone}"
	cidr_block			= "${var.bastion-host-subnet-ip-address-range}"
	enable_dns64			= "false"
	map_public_ip_on_launch			= "false"
	private_dns_hostname_type_on_launch	= "resource-name"
	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "bastion-host-subnet"
		Purpose = "bastion-host-subnet"
	}
}


