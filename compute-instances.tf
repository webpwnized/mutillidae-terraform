
locals {
	instance-project		= "${var.project}"
	instance-region			= "${var.region}"
	instance-zone			= "${var.zone}"
	instance-network-name		= "${google_compute_network.gcp_vpc_network.name}"
	instance-subnetwork-name	= "${google_compute_subnetwork.gcp_vpc_iaas_subnetwork.name}"
	instance-ssh-username		= "${var.gcp-ssh-username}"
	instance-ssh-public-key-file	= "${var.gcp-ssh-public-key-file}"
	instance-bastion-host-vm-name 	= "bastion-host-vm-t"
	instance-disk-size-gb		= 10 //GB
}

resource "google_compute_instance" "gcp_instance_bastion_host" {
	project				= "${local.instance-project}"
	zone				= "${local.instance-zone}"
	name				= "${local.instance-bastion-host-vm-name}"
	description			= "A jump server to allow access to other IaaS on the ${local.instance-subnetwork-name} subnet"
	machine_type			= "e2-small"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = ["bastion-host"]
	labels = {
		"purpose"	= "general-computing"
		"owner"		= "jeremy-druin"
		"asset-type"	= "virtual-machine"
	}
	boot_disk {
		auto_delete	= true
		device_name	= "${local.instance-bastion-host-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.instance-disk-size-gb
			type	= "pd-standard"
			image	= "debian-cloud/debian-11"
		}
	}
	network_interface {
		network 		= "${local.instance-network-name}"
		subnetwork 		= "${local.instance-subnetwork-name}"
		subnetwork_project 	= "${local.instance-project}"
		network_ip		= "10.0.0.2"
		stack_type		= "IPV4_ONLY"
	}
	shielded_instance_config {
		enable_secure_boot		= true
		enable_vtpm			= true
		enable_integrity_monitoring	= true
	}
	metadata = {
		ssh-keys = "${local.instance-ssh-username}:${file(local.instance-ssh-public-key-file)}"
		startup-script	= "#! /bin/bash\n# Google runs these commands as root user\napt update\napt upgrade -y"
 	}
} // end resource "google_compute_instance" "gcp_instance_bastion_host"


