resource "aws_vpc" "mutillidae-vpc" {
	cidr_block		= "10.0.0.0/16"
	instance_tenancy	= "default"

}
