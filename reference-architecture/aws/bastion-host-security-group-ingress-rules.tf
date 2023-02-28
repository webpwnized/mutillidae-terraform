
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule

resource "aws_security_group_rule" "allow-ingress-https-from-vpc-endpoints" {
	security_group_id	= "${aws_security_group.bastion-host-security-group.id}"
	type            	= "ingress"
	from_port       	= 443
	to_port        		= 443
	protocol		= "tcp"
	cidr_blocks		= ["${var.bastion-host-ip-address}/32"]
	description		= "allow-ingress-https-from-vpc-endpoints"
}

