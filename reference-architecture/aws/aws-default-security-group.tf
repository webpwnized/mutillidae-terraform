# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group.html

# When Terraform first begins managing the default security group, it immediately removes all ingress and egress rules in the Security Group

locals {
	aws-default-security-group-name = "aws-default-security-group"
}

resource "aws_default_security_group" "default" {

	vpc_id	= "${aws_vpc.mutillidae-vpc.id}"
	
	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.aws-default-security-group-name}"
		Purpose = "${local.aws-default-security-group-name}"
	}
}
