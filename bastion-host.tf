
locals {
	bastion-host-project			= "${google_compute_network.gcp_vpc_network.project}"
	bastion-host-region			= "${var.region}"
	bastion-host-zone			= "${var.zone}"
	bastion-host-network-name		= "${google_compute_network.gcp_vpc_network.name}"
	bastion-host-subnetwork-name		= "${google_compute_subnetwork.gcp_vpc_iaas_subnetwork.name}"
	bastion-host-ssh-username		= "${var.gcp-ssh-username}"
	bastion-host-ssh-public-key-file	= "${var.gcp-ssh-public-key-file}"
	
	//Make sure these are set for this machine
	bastion-host-vm-name 			= "bastion-host-vm-t"
	bastion-host-network-ip			= "10.0.0.2"
	bastion-host-disk-size-gb		= 10 //GB
	bastion-host-description		= "A jump server to allow access to other IaaS on the ${local.bastion-host-subnetwork-name} subnet"

}

resource "google_compute_instance" "gcp_instance_bastion_host" {
	project				= "${local.bastion-host-project}"
	zone				= "${local.bastion-host-zone}"
	name				= "${local.bastion-host-vm-name}"
	description			= "${local.bastion-host-description}"
	machine_type			= "e2-small"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = ["bastion-host"]
	labels = {
		"purpose"	= "bastion-host"
		"owner"		= "jeremy-druin"
		"asset-type"	= "virtual-machine"
	}
	boot_disk {
		auto_delete	= true
		device_name	= "${local.bastion-host-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.bastion-host-disk-size-gb
			type	= "pd-standard"
			image	= "debian-cloud/debian-11"
		}
	}
	network_interface {
		network 		= "${local.bastion-host-network-name}"
		subnetwork 		= "${local.bastion-host-subnetwork-name}"
		subnetwork_project 	= "${local.bastion-host-project}"
		network_ip		= "${local.bastion-host-network-ip}"
		stack_type		= "IPV4_ONLY"
	}
	shielded_instance_config {
		enable_secure_boot		= true
		enable_vtpm			= true
		enable_integrity_monitoring	= true
	}
	metadata = {
		ssh-keys = "${local.bastion-host-ssh-username}:${file(local.bastion-host-ssh-public-key-file)}"
		startup-script	= "#! /bin/bash\n# Google runs these commands as root user\napt update\napt upgrade -y"
 	}
} // end resource "google_compute_instance" "gcp_instance_bastion_host"


