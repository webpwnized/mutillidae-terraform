
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

locals {
	internet-gateway-name	= "internet-gateway"
}

resource "aws_internet_gateway" "internet-gateway" {

	vpc_id = "${aws_vpc.mutillidae-vpc.id}"

	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.internet-gateway-name}"
		Purpose = "${local.internet-gateway-name}"
	}
}
