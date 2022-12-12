
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association

locals {
	private-endpoint-route-table-name	= "private-endpoint-route-table"
	internet-route-table-name		= "internet-route-table"
}

# Create a Route Table to route requests to VPC Private Endpoints
resource "aws_route_table" "private-endpoint-route-table" {
	
	vpc_id	= "${aws_vpc.mutillidae-vpc.id}"

	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.private-endpoint-route-table-name}"
		Purpose = "${local.private-endpoint-route-table-name}"
	}

}

# Associate the Route Table with the Subnet that will send traffic to the VPC Private Endpoints
resource "aws_route_table_association" "bastion-host-subnet-private-endpoint-route-table-association" {
	subnet_id	= aws_subnet.bastion-host-subnet.id
	route_table_id	= aws_route_table.private-endpoint-route-table.id
}

# Associate the VPC Private Endpoint with the Route Table
resource "aws_vpc_endpoint_route_table_association" "ssm-private-endpoint-private-endpoint-route-table-association" {
	route_table_id  = aws_route_table.private-endpoint-route-table.id
	vpc_endpoint_id = aws_vpc_endpoint.ssm-private-endpoint.id
}

# Associate the VPC Private Endpoint with the Route Table
resource "aws_vpc_endpoint_route_table_association" "s3-private-endpoint-private-endpoint-route-table-association" {
	route_table_id  = aws_route_table.private-endpoint-route-table.id
	vpc_endpoint_id = aws_vpc_endpoint.s3-private-gateway.id
}

resource "aws_route_table" "internet-route-table" {

	vpc_id	= "${aws_vpc.mutillidae-vpc.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.internet-gateway.id}
	}

	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.internet-route-table-name}"
		Purpose = "${local.internet-route-table-name}"
	}

}

resource "aws_route_table_association" "bastion-host-subnet-internet-route-table-association" {
	subnet_id      = "${aws_subnet.bastion-host-subnet.id}"
	route_table_id = "${aws_route_table.internet-route-table.id}"
}

