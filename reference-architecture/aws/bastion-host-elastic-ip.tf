resource "aws_eip" "ip-test-env" {
	instance	= "${aws_instance.bastion-host.id}"
	vpc		= "true"
}
