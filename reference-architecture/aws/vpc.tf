# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "mutillidae-vpc" {
	cidr_block		= "10.0.0.0/16"
	instance_tenancy	= "default"
	enable_dns_support	= "true"
	enable_dns_hostnames	= "true"
}

output "vpc_arn" {
	value		= "${aws_vpc.mutillidae-vpc.arn}"
	description	= "Amazon Resource Name (ARN) of VPC"
	sensitive	= false
}

output "vpc_owner_id" {
	value		= "${aws_vpc.mutillidae-vpc.owner_id}"
	description	= "The ID of the AWS account that owns the VPC"
	sensitive	= false
}

