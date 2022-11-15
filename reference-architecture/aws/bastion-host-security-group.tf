
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface

locals {
	bastion-host-security-group-name	= "bastion-host-security-group"
}

resource "aws_security_group" "bastion-host-security-group" {
	
	name	= "${local.bastion-host-security-group-name}"
	vpc_id	= "${aws_vpc.mutillidae-vpc.id}"

	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.bastion-host-security-group-name}"
		Purpose = "${local.bastion-host-security-group-name}"
	}

	lifecycle {
		# Necessary if changing 'name' or 'name_prefix' properties.
		create_before_destroy = true
	}
}
