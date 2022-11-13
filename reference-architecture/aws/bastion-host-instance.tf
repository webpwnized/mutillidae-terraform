
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

# Search for Amazon Machine Image (AMI) ID with
#	aws ec2 describe-images --output json --region us-east-1 --filters "Name=name,Values=ubuntu-minimal/images/hvm-ssd/ubuntu-*amd64*" --query 'sort_by(Images, &CreationDate)[-1].{Name: Name, ImageId: ImageId, CreationDate: CreationDate, Owner:OwnerId}'

# Pricing information: https://aws.amazon.com/ec2/pricing/on-demand/
# t3.micro	$0.0104	2	1 GiB	EBS Only	Up to 5 Gigabit

locals {
	bastion-host-name	= "bastion-host"
}

resource "aws_instance" "bastion-host" {
	ami           		= "ami-00904dae345443dac"
	availability_zone	= "${var.availability-zone}"
	instance_type 		= "t3.micro"
	subnet_id       	= aws_subnet.bastion-host-subnet.id
	
	associate_public_ip_address	= "false"

	network_interface {
		network_interface_id	= aws_network_interface.bastion-host-network-interface.id
		device_index		= 0
		network_card_index	= 0
		delete_on_termination	= "false"
	}

	credit_specification {
		cpu_credits = "unlimited"
	}
	
	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.bastion-host-name}"
		Purpose = "${local.bastion-host-name}"
	}
}
