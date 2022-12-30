resource "aws_eip" "ip-test-env" {
	instance	= "${aws_instance.bastion-host.id}"
	vpc		= "true"
}

output "bastion-host-external-public-dns" {
	value 		= "${aws_eip.ip-test-env.public_dns}"
	description 	= "Public DNS associated with the Elastic IP address"
	sensitive	= "false"
}

output "bastion-host-external-public-ip" {
	value 		= "${aws_eip.ip-test-env.public_ip}"
	description 	= "Contains the public IP address"
	sensitive	= "false"
}

