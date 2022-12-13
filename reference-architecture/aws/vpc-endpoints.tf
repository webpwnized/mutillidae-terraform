
# https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint

# https://aws.amazon.com/premiumsupport/knowledge-center/ec2-systems-manager-vpc-endpoints/

resource "aws_vpc_endpoint" "ssm-private-endpoint" {
	vpc_id			= aws_vpc.mutillidae-vpc.id
	subnet_ids		= ["${aws_subnet.bastion-host-subnet.id}"]
	service_name		= "com.amazonaws.${var.region}.ssm"
	vpc_endpoint_type	= "Interface"
	ip_address_type		= "ipv4"

	security_group_ids = [
		aws_security_group.bastion-host-security-group.id,
	]

	private_dns_enabled = true
}

output "ssm-private-endpoint-dns-entry" {
	value		= "${aws_vpc_endpoint.ssm-private-endpoint.dns_entry}"
	description	= "The DNS entries for the VPC Endpoint"
	sensitive	= "false"
}

output "ssm-private-endpoint-state" {
	value		= "${aws_vpc_endpoint.ssm-private-endpoint.state}"
	description	= "The state of the VPC endpoint"
	sensitive	= "false"
}

resource "aws_vpc_endpoint" "ec2messages-private-endpoint" {
	vpc_id			= aws_vpc.mutillidae-vpc.id
	subnet_ids		= ["${aws_subnet.bastion-host-subnet.id}"]
	service_name		= "com.amazonaws.${var.region}.ec2messages"
	vpc_endpoint_type	= "Interface"

	security_group_ids = [
		aws_security_group.bastion-host-security-group.id,
	]

	private_dns_enabled = true
}

output "ec2messages-private-endpoint-dns-entry" {
	value		= "${aws_vpc_endpoint.ec2messages-private-endpoint.dns_entry}"
	description	= "The DNS entries for the VPC Endpoint"
	sensitive	= "false"
}

output "ec2messages-private-endpoint-state" {
	value		= "${aws_vpc_endpoint.ec2messages-private-endpoint.state}"
	description	= "The state of the VPC endpoint"
	sensitive	= "false"
}

resource "aws_vpc_endpoint" "ec2-private-endpoint" {
	vpc_id            = aws_vpc.mutillidae-vpc.id
	subnet_ids		= ["${aws_subnet.bastion-host-subnet.id}"]
	service_name      = "com.amazonaws.${var.region}.ec2"
	vpc_endpoint_type = "Interface"

	security_group_ids = [
		aws_security_group.bastion-host-security-group.id,
	]

	private_dns_enabled = true
}

output "ec2-private-endpoint-dns-entry" {
	value		= "${aws_vpc_endpoint.ec2-private-endpoint.dns_entry}"
	description	= "The DNS entries for the VPC Endpoint"
	sensitive	= "false"
}

output "ec2-private-endpoint-state" {
	value		= "${aws_vpc_endpoint.ec2-private-endpoint.state}"
	description	= "The state of the VPC endpoint"
	sensitive	= "false"
}

resource "aws_vpc_endpoint" "ssmmessages-private-endpoint" {
	vpc_id            = aws_vpc.mutillidae-vpc.id
	subnet_ids		= ["${aws_subnet.bastion-host-subnet.id}"]
	service_name      = "com.amazonaws.${var.region}.ssmmessages"
	vpc_endpoint_type = "Interface"

	security_group_ids = [
		aws_security_group.bastion-host-security-group.id,
	]

	private_dns_enabled = true
}

output "ssmmessages-private-endpoint-dns-entry" {
	value		= "${aws_vpc_endpoint.ssmmessages-private-endpoint.dns_entry}"
	description	= "The DNS entries for the VPC Endpoint"
	sensitive	= "false"
}

output "ssmmessages-private-endpoint-state" {
	value		= "${aws_vpc_endpoint.ssmmessages-private-endpoint.state}"
	description	= "The state of the VPC endpoint"
	sensitive	= "false"
}

resource "aws_vpc_endpoint" "kms-private-endpoint" {
	vpc_id            = aws_vpc.mutillidae-vpc.id
	subnet_ids		= ["${aws_subnet.bastion-host-subnet.id}"]
	service_name      = "com.amazonaws.${var.region}.kms"
	vpc_endpoint_type = "Interface"

	security_group_ids = [
		aws_security_group.bastion-host-security-group.id,
	]

	private_dns_enabled = true
}

output "kms-private-endpoint-dns-entry" {
	value		= "${aws_vpc_endpoint.kms-private-endpoint.dns_entry}"
	description	= "The DNS entries for the VPC Endpoint"
	sensitive	= "false"
}

output "kms-private-endpoint-state" {
	value		= "${aws_vpc_endpoint.kms-private-endpoint.state}"
	description	= "The state of the VPC endpoint"
	sensitive	= "false"
}

resource "aws_vpc_endpoint" "logs-private-endpoint" {
	vpc_id            = aws_vpc.mutillidae-vpc.id
	subnet_ids		= ["${aws_subnet.bastion-host-subnet.id}"]
	service_name      = "com.amazonaws.${var.region}.logs"
	vpc_endpoint_type = "Interface"

	security_group_ids = [
		aws_security_group.bastion-host-security-group.id,
	]

	private_dns_enabled = true
}

output "logs-private-endpoint-dns-entry" {
	value		= "${aws_vpc_endpoint.logs-private-endpoint.dns_entry}"
	description	= "The DNS entries for the VPC Endpoint"
	sensitive	= "false"
}

output "logs-private-endpoint-state" {
	value		= "${aws_vpc_endpoint.logs-private-endpoint.state}"
	description	= "The state of the VPC endpoint"
	sensitive	= "false"
}

resource "aws_vpc_endpoint" "s3-private-gateway" {
	vpc_id			= aws_vpc.mutillidae-vpc.id
	service_name		= "com.amazonaws.${var.region}.s3"
	vpc_endpoint_type	= "Gateway"
}

output "s3-private-gateway-cidr-blocks" {
	value		= "${aws_vpc_endpoint.s3-private-gateway.cidr_blocks}"
	description	= "The list of CIDR blocks for the exposed AWS service"
	sensitive	= "false"
}




