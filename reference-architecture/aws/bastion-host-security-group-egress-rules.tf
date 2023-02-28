
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule

#resource "aws_security_group_rule" "allow-egress-https-bastion-host-to-private-gateway" {
#	security_group_id = "${aws_security_group.bastion-host-security-group.id}"
#	type			= "egress"
#	from_port         	= 443
#	to_port           	= 443
#	protocol          	= "tcp"
#	description		= "allow-egress-https-bastion-host-to-private-services"
#	cidr_blocks		= ["0.0.0.0/0"]
#	prefix_list_ids   = [
#		"${aws_vpc_endpoint.s3-private-gateway.prefix_list_id}"
#	]
#}

resource "aws_security_group_rule" "allow-egress-https-bastion-host-to-internet-gateway" {
	security_group_id = "${aws_security_group.bastion-host-security-group.id}"
	type			= "egress"
	from_port         	= 443
	to_port           	= 443
	protocol          	= "tcp"
	description		= "allow-egress-https-bastion-host-to-internet-gateway"
	cidr_blocks		= ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow-egress-http-bastion-host-to-internet-gateway" {
	security_group_id = "${aws_security_group.bastion-host-security-group.id}"
	type			= "egress"
	from_port         	= 80
	to_port           	= 80
	protocol          	= "tcp"
	description		= "allow-egress-http-bastion-host-to-internet-gateway"
	cidr_blocks		= ["0.0.0.0/0"]
}

