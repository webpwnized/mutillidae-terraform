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

output "vpc_arn" {
	value		= "${aws_vpc.mutillidae-vpc.arn}"
	description	= "Amazon Resource Name (ARN) of VPC"
	sensitive	= false
	depends_on	= [aws_vpc.mutillidae-vpc]
}

output "vpc_owner_id" {
	value		= "${aws_vpc.mutillidae-vpc.owner_id}"
	description	= "The ID of the AWS account that owns the VPC"
	sensitive	= false
	depends_on	= [aws_vpc.mutillidae-vpc]
}

