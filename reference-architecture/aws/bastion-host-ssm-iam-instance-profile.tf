
# https://medium.com/@khimananda.oli/terraform-aws-ec2-and-system-manager-e0f0c914132c

# https://aws.amazon.com/premiumsupport/knowledge-center/ec2-systems-manager-vpc-endpoints/

locals {
	bastion-host-iam-instance-profile-name	= "bastion-host-iam-instance-profile"
	bastion-host-iam-role-name		= "bastion-host-iam-role"
}

resource "aws_iam_instance_profile" "bastion-host-iam-instance-profile" {
	name = "${local.bastion-host-iam-instance-profile-name}"
	role = "${aws_iam_role.bastion-host-iam-role.name}"
	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.bastion-host-iam-instance-profile-name}"
		Purpose = "${local.bastion-host-iam-instance-profile-name}"
	}
}

resource "aws_iam_role" "bastion-host-iam-role" {
	name        = "${local.bastion-host-iam-role-name}"
	description = "The IAM role for the EC2 instance"
	assume_role_policy = <<EOF
	{
		"Version": "2012-10-17",
		"Statement": {
			"Effect": "Allow",
			"Principal": {"Service": "ec2.amazonaws.com"},
			"Action": "sts:AssumeRole"
		}
	}
	EOF

	tags = {
		# AWS uses the Name tag to set the subnet name. Tags are case-sensitive.
		Name	= "${local.bastion-host-iam-role-name}"
		Purpose = "${local.bastion-host-iam-role-name}"
	}
}

resource "aws_iam_role_policy_attachment" "bastion-host-attach-policy-1" {
	role       = "${aws_iam_role.bastion-host-iam-role.name}"
	policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "bastion-host-attach-policy-2" {
	role       = "${aws_iam_role.bastion-host-iam-role.name}"
	policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}



