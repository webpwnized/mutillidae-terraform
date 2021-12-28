
locals {
	bastion-host-project			= "${google_compute_network.gcp_vpc_network.project}"
	bastion-host-region			= "${var.region}"
	bastion-host-zone			= "${var.zone}"
	bastion-host-network-name		= "${google_compute_network.gcp_vpc_network.name}"
	bastion-host-subnetwork-name		= "${google_compute_subnetwork.gcp_vpc_iaas_subnetwork.name}"
	
	//Make sure these are set for this machine
	bastion-host-vm-name 			= "bastion-host-vm"
	bastion-host-network-ip			= "10.0.0.2"
	bastion-host-tags 			= ["bastion-host"]
	bastion-host-disk-size-gb		= 10
	bastion-host-description		= "A jump server to allow access to other IaaS on the ${local.bastion-host-subnetwork-name} subnet"
	bastion-host-labels 			= "${merge(
							tomap({ 
								"purpose"	= "bastion-host",
								"asset-type"	= "virtual-machine"
							}),
							var.default_labels)
						}"
}

data "cloudinit_config" "bastion_host_configuration" {
  gzip = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = file("bastion-host.cloud-init.yaml")
    filename = "bastion-host.cloud-init.conf"
  }
}

resource "google_compute_instance" "gcp_instance_bastion_host" {
	project				= "${local.bastion-host-project}"
	zone				= "${local.bastion-host-zone}"
	name				= "${local.bastion-host-vm-name}"
	description			= "${local.bastion-host-description}"
	machine_type			= "${var.vm_machine_type}"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = local.bastion-host-tags
	labels = local.bastion-host-labels
	boot_disk {
		auto_delete	= true
		device_name	= "${local.bastion-host-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.bastion-host-disk-size-gb
			type	= "${var.vm_boot_disk_type}"
			image	= "${var.vm_boot_disk_image}"
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
		ssh-keys = "${var.gcp-ssh-username}:${file(var.gcp-ssh-public-key-file)}"
		startup-script	= "${var.vm-metadata-startup-script}"
		user-data = "${data.cloudinit_config.bastion_host_configuration.rendered}"
 	}	
} // end resource "google_compute_instance" "gcp_instance_bastion_host"


