
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance

locals {
	// These default values should work without changes
	bastion-host-network-name		= "${google_compute_network.gcp_vpc_network.name}"
	bastion-host-subnetwork-name		= "${google_compute_subnetwork.gcp-vpc-bastion-host-subnetwork.name}"
	bastion-host-cloud-init-config-file	= "./cloud-init/bastion-host.yaml"
	
	//Make sure these are set for this machine
	bastion-host-vm-name 			= "bastion-host"
	bastion-host-vm-boot-disk-image		= "ubuntu-os-cloud/ubuntu-minimal-2304-amd64"
	bastion-host-network-ip			= "10.0.0.5"
	bastion-host-tags 			= ["bastion-host","iaas-host"]
	bastion-host-disk-size-gb		= 10
	bastion-host-description		= "A jump server to allow access to other IaaS on the ${local.bastion-host-subnetwork-name} subnet"
	bastion-host-labels 			= "${merge(
							tomap({ 
								"purpose"	= "bastion-host",
								"asset-type"	= "virtual-machine"
							}),
							var.default-labels)
						}"
}

data "cloudinit_config" "bastion_host_configuration" {
	gzip = false
	base64_encode = false

	part {
		content_type = "text/cloud-config"
		content = templatefile("${local.bastion-host-cloud-init-config-file}",
			{
				username		= "${var.ssh-username}"
				# We do not need to pass the public key when using OS Login
				#ssh-public-key		= "${file(var.ssh-public-key-file)}"
			}
		)
		filename = "${local.bastion-host-cloud-init-config-file}"
	}
}

resource "google_compute_instance" "gcp_instance_bastion_host" {
	project				= "${google_compute_network.gcp_vpc_network.project}"
	zone				= "${var.zone}"
	name				= "${local.bastion-host-vm-name}"
	description			= "${local.bastion-host-description}"
	machine_type			= "${var.vm-machine-type}"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = local.bastion-host-tags
	labels = local.bastion-host-labels
	service_account {
		email  = google_service_account.bastion-host-service-account.email
		scopes = ["cloud-platform"]
	}
	boot_disk {
		auto_delete	= true
		device_name	= "${local.bastion-host-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.bastion-host-disk-size-gb
			type	= "${var.vm-boot-disk-type}"
			image	= "${local.bastion-host-vm-boot-disk-image}"
		}
	}
	network_interface {
		network 		= "${local.bastion-host-network-name}"
		subnetwork 		= "${local.bastion-host-subnetwork-name}"
		subnetwork_project 	= "${var.project}"
		network_ip		= "${local.bastion-host-network-ip}"
		stack_type		= "IPV4_ONLY"
	}
	shielded_instance_config {
		enable_secure_boot		= true
		enable_vtpm			= true
		enable_integrity_monitoring	= true
	}
	# We cannot use confidential computing because that requires hosts to set on_host_maintenance = "TERMINATE" which in turn requires hosts to be preemptable. 
	# confidential_instance_config {
	# 	enable_confidential_compute	= true
	# }
	# scheduling {
	# 	# Required for confidential computing
	# 	on_host_maintenance		= "TERMINATE"
	# }
	metadata = {
		# Lab anchor points allow the lab scripts to change the file to set up labs
		# Lab-22-Anchor-Point
		# We enable OS Login and OS Config at the Project Level
		# enable-oslogin	= "TRUE"
		# enable-oslogin-2fa	= "TRUE"
		# We do not need to pass the public key when using OS Login
		# ssh-keys 		= "${var.ssh-username}:${file(var.ssh-public-key-file)}"
		block-project-ssh-keys	= "TRUE"
		startup-script		= "${var.vm-metadata-startup-script}"
		user-data 		= "${data.cloudinit_config.bastion_host_configuration.rendered}"
 	}	
} // end resource "google_compute_instance" "gcp_instance_bastion_host"

output "bastion-host-cpu-platform" {
	value 		= "${google_compute_instance.gcp_instance_bastion_host.cpu_platform}"
	description	= "The CPU platform used by this instance"
}

output "bastion-host-internal-ip-address" {
	value 		= "${google_compute_instance.gcp_instance_bastion_host.network_interface.0.network_ip}"
	description	= "The internal ip address of the instance, either manually or dynamically assigned"
}

output "bastion-host-external-ip-address" {
	  value = length(google_compute_instance.gcp_instance_bastion_host.network_interface.0.access_config.*.nat_ip) > 0 ? google_compute_instance.gcp_instance_bastion_host.network_interface.0.access_config.*.nat_ip : null
	description	= "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip"
}

