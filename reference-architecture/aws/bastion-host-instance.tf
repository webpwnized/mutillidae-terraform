
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

# Search for Amazon Machine Image (AMI) ID with
#	aws ec2 describe-images --output json --region us-east-1 --filters "Name=name,Values=ubuntu-minimal/images/hvm-ssd/ubuntu-*amd64*" --query 'sort_by(Images, &CreationDate)[-1].{Name: Name, ImageId: ImageId, CreationDate: CreationDate, Owner:OwnerId}'
# "ami-00904dae345443dac" - Ubuntu 22.10 Minimal (No Sesssion Manager installed)
# "ami-0c04187570dfc5ccf" - ubuntu-focal-20.04-amd64-minimal

# Pricing information: https://aws.amazon.com/ec2/pricing/on-demand/
# t3.micro	$0.0104	2	1 GiB	EBS Only	Up to 5 Gigabit

locals {
	bastion-host-name	= "bastion-host"
}

resource "aws_key_pair" "aws-ssh-key" {
  key_name   = "aws-ssh-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINCh6uFBnUmWPjc+0AZUvEl1/Bukf29UZOfDbMAqqblQ jeremy@ubuntu-cloud"
}


resource "aws_instance" "bastion-host" {
	ami           		= "ami-0c04187570dfc5ccf"
	availability_zone	= "${var.availability-zone}"
	instance_type 		= "t3.micro"
	
	# Subnet is specified in the Network Interface
	# subnet_id       	= "${aws_subnet.bastion-host-subnet.id}"
	
	# IP is specified in the Network Interface
	#associate_public_ip_address	= "false"
	
	key_name	= "${aws_key_pair.aws-ssh-key.key_name}"
	
	iam_instance_profile	= "${aws_iam_instance_profile.bastion-host-iam-instance-profile.name}"

	root_block_device {
		delete_on_termination	= "true"
		encrypted		= "true"
		volume_size		= 10 #Gb
		volume_type		= "gp2"
		tags = {
			# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
			Name	= "${local.bastion-host-name}-disk"
			Purpose = "${local.bastion-host-name}-disk"
		}
	}

	network_interface {
		network_interface_id	= aws_network_interface.bastion-host-network-interface.id
		device_index		= 0
		network_card_index	= 0
		delete_on_termination	= "false"
	}

	credit_specification {
		cpu_credits = "unlimited"
	}
	
	private_dns_name_options {
		enable_resource_name_dns_a_record	= "true"
		hostname_type				= "ip-name"
	}
	
	metadata_options {
		http_endpoint			= "enabled"
		http_put_response_hop_limit	= 1
		http_tokens			= "required"
		instance_metadata_tags		= "enabled"
	}

	user_data_replace_on_change		= "true"
	user_data = <<EOF
		#!/bin/bash
		mkdir /tmp/ssm
		cd /tmp/ssm
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
		sudo dpkg -i amazon-ssm-agent.deb
		sudo systemctl enable amazon-ssm-agent
	EOF
	
	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.bastion-host-name}"
		Purpose = "${local.bastion-host-name}"
	}
}

output "bastion-host-instance-state" {
	value		= "${aws_instance.bastion-host.instance_state}"
	description	= "State of the instance. One of: pending, running, shutting-down, terminated, stopping, stopped"
	sensitive	= "false"
}

output "bastion-host-private-dns" {
	value		= "${aws_instance.bastion-host.private_dns}"
	description	= "Private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC."
	sensitive	= "false"
}

output "bastion-host-public-dns" {
	value		= "${aws_instance.bastion-host.private_dns}"
	description	= "Public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC."
	sensitive	= "false"
}

output "bastion-host-public-ip" {
	value		= "${aws_instance.bastion-host.public_ip}"
	description	= "Public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip as this field will change after the EIP is attached."
	sensitive	= "false"
}


