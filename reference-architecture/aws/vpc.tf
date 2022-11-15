# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "mutillidae-vpc" {
	cidr_block		= "${var.vpc-ip-address-range}"
	instance_tenancy	= "default"
	enable_dns_support	= "true"
	enable_dns_hostnames	= "false"
	tags = {
		# AWS uses the Name tag to set the name. Tags are case-sensitive.
		Name	= "application-vpc"
		Purpose = "application-vpc"
	}
}

