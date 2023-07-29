
locals {
	// The default value of these variables should work
	application-server-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	application-server-subnetwork-name	= "${google_compute_subnetwork.gcp-vpc-application-server-subnetwork.name}"
	application-server-cloud-init-config-file	= "./cloud-init/application-server.yaml"
	
	//Make sure these are set for this machine
	application-server-vm-name			= "application-server"
	application-server-vm-boot-disk-image	= "ubuntu-os-cloud/ubuntu-2204-lts"
	application-server-network-ip		= "10.0.1.5"
	application-server-tags 			= ["application-server","web-server","iaas-host"]
	application-server-disk-size-gb		= 25
	application-server-description		= "A application server to run containers on the ${local.application-server-subnetwork-name} subnet"

	application-server-labels 		= "${merge(
						tomap({ 
							"purpose"	= "application-server",
							"asset-type"	= "virtual-machine"
						}),
						var.default-labels)
					}"
}

data "cloudinit_config" "application_server_configuration" {
	gzip = false
	base64_encode = false

	part {
		content_type = "text/cloud-config"
		content = templatefile("${local.application-server-cloud-init-config-file}",
			{
				username		= "${var.ssh-username}"
				# We do not need to pass the public key when using OS Login
				# ssh-public-key	= "${file(var.ssh-public-key-file)}"
				database-username	= "${google_sql_user.mysql-account.name}"
				database-password	= "${google_sql_user.mysql-account.password}"
				database-ip-address	= "${google_sql_database_instance.mysql.private_ip_address}"
			}
		)
		filename = "${local.application-server-cloud-init-config-file}"
	}
}

resource "google_compute_instance" "gcp_instance_application_server" {

	depends_on = [
		google_sql_database_instance.mysql,
		google_compute_router_nat.gcp-vpc-nat-router-nat-service
	]
	
	project				= "${google_compute_network.gcp_vpc_network.project}"
	zone				= "${var.zone}"
	name				= "${local.application-server-vm-name}"
	description			= "${local.application-server-description}"
	machine_type			= "${var.vm-machine-type}"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = "${local.application-server-tags}"
	labels = "${local.application-server-labels}"
	service_account {
		email  = google_service_account.application-server-service-account.email
		scopes = ["cloud-platform"]
	}
	boot_disk {
		auto_delete	= true
		device_name	= "${local.application-server-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.application-server-disk-size-gb
			type	= "${var.vm-boot-disk-type}"
			image	= "${local.application-server-vm-boot-disk-image}"
		}
	}
	network_interface {
		network 		= "${local.application-server-network-name}"
		subnetwork 		= "${local.application-server-subnetwork-name}"
		subnetwork_project 	= "${var.project}"
		network_ip		= "${local.application-server-network-ip}"
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
		user-data 		= "${data.cloudinit_config.application_server_configuration.rendered}"
 	}
} // end resource "google_compute_instance" "gcp_instance_application_server"

output "application-server-cpu-platform" {
	value 		= "${google_compute_instance.gcp_instance_application_server.cpu_platform}"
	description	= "The CPU platform used by this instance"
}

output "application-server-internal-ip-address" {
	value 		= "${google_compute_instance.gcp_instance_application_server.network_interface.0.network_ip}"
	description	= "The internal ip address of the instance, either manually or dynamically assigned"
}

output "application-server-external-ip-address" {
	  value = length(google_compute_instance.gcp_instance_application_server.network_interface.0.access_config.*.nat_ip) > 0 ? google_compute_instance.gcp_instance_application_server.network_interface.0.access_config.*.nat_ip : null
	description	= "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip"
}


