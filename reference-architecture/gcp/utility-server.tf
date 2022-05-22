
locals {
	// The default value of these variables should work
	utility-server-project		= "${var.project}"
	utility-server-region		= "${var.region}"
	utility-server-zone		= "${var.zone}"
	utility-server-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	utility-server-subnetwork-name	= "${google_compute_subnetwork.gcp-vpc-application-server-subnetwork.name}"
	utility-server-cloud-init-config-file	= "./cloud-init/utility-server.yaml"
	
	//Make sure these are set for this machine
	utility-server-vm-name			= "utility-server"
	utility-server-vm-boot-disk-image	= "ubuntu-os-cloud/ubuntu-2110"
	utility-server-network-ip		= "10.0.1.6"
	utility-server-tags 			= ["utility-server","iaas-host"]
	utility-server-disk-size-gb		= 10
	utility-server-description		= "A utility server on the ${local.utility-server-subnetwork-name} subnet"

	utility-server-labels 		= "${merge(
						tomap({ 
							"purpose"	= "utility-server",
							"asset-type"	= "virtual-machine"
						}),
						var.default-labels)
					}"
}

data "cloudinit_config" "utility_server_configuration" {
	gzip = false
	base64_encode = false

	part {
		content_type = "text/cloud-config"
		content = templatefile("${local.utility-server-cloud-init-config-file}",
			{
				username		= "${var.ssh-username}"
				ssh-public-key		= "${file(var.ssh-public-key-file)}"
			}
		)
		filename = "${local.utility-server-cloud-init-config-file}"
	}
}

resource "google_compute_instance" "gcp_instance_utility_server" {
	project				= "${local.utility-server-project}"
	zone				= "${local.utility-server-zone}"
	name				= "${local.utility-server-vm-name}"
	description			= "${local.utility-server-description}"
	machine_type			= "${var.vm-machine-type}"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = "${local.utility-server-tags}"
	labels = "${local.utility-server-labels}"
	boot_disk {
		auto_delete	= true
		device_name	= "${local.utility-server-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.utility-server-disk-size-gb
			type	= "${var.vm-boot-disk-type}"
			image	= "${local.utility-server-vm-boot-disk-image}"
		}
	}
	network_interface {
		network 		= "${local.utility-server-network-name}"
		subnetwork 		= "${local.utility-server-subnetwork-name}"
		subnetwork_project 	= "${local.utility-server-project}"
		network_ip		= "${local.utility-server-network-ip}"
		stack_type		= "IPV4_ONLY"
	}
	shielded_instance_config {
		enable_secure_boot		= true
		enable_vtpm			= true
		enable_integrity_monitoring	= true
	}
	metadata = {
		ssh-keys = "${var.ssh-username}:${file(var.ssh-public-key-file)}"
		startup-script	= "${var.vm-metadata-startup-script}"
		user-data = "${data.cloudinit_config.utility_server_configuration.rendered}"
 	}
} // end resource "google_compute_instance" "gcp_instance_utility_server"

output "utility-server-cpu-platform" {
	value 		= "${google_compute_instance.gcp_instance_utility_server.cpu_platform}"
	description	= "The CPU platform used by this instance"
}

output "utility-server-internal-ip-address" {
	value 		= "${google_compute_instance.gcp_instance_utility_server.network_interface.0.network_ip}"
	description	= "The internal ip address of the instance, either manually or dynamically assigned"
}

output "utility-server-external-ip-address" {
	  value = length(google_compute_instance.gcp_instance_utility_server.network_interface.0.access_config.*.nat_ip) > 0 ? google_compute_instance.gcp_instance_utility_server.network_interface.0.access_config.*.nat_ip : null
	description	= "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip"
}


