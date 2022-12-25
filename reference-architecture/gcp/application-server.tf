
locals {
	// The default value of these variables should work
	docker-server-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	docker-server-subnetwork-name	= "${google_compute_subnetwork.gcp-vpc-application-server-subnetwork.name}"
	docker-server-cloud-init-config-file	= "./cloud-init/docker-server.yaml"
	
	//Make sure these are set for this machine
	docker-server-vm-name			= "docker-server"
	docker-server-vm-boot-disk-image	= "ubuntu-os-cloud/ubuntu-2204-lts"
	docker-server-network-ip		= "10.0.1.5"
	docker-server-tags 			= ["docker-server","web-server","iaas-host"]
	docker-server-disk-size-gb		= 25
	docker-server-description		= "A docker server to run containers on the ${local.docker-server-subnetwork-name} subnet"

	docker-server-labels 		= "${merge(
						tomap({ 
							"purpose"	= "application-server",
							"asset-type"	= "virtual-machine"
						}),
						var.default-labels)
					}"
}

data "cloudinit_config" "docker_server_configuration" {
	gzip = false
	base64_encode = false

	part {
		content_type = "text/cloud-config"
		content = templatefile("${local.docker-server-cloud-init-config-file}",
			{
				username		= "${var.ssh-username}"
				ssh-public-key		= "${file(var.ssh-public-key-file)}"
				database-username	= "${google_sql_user.mysql-account.name}"
				database-password	= "${google_sql_user.mysql-account.password}"
				database-ip-address	= "${google_sql_database_instance.mysql.private_ip_address}"
			}
		)
		filename = "${local.docker-server-cloud-init-config-file}"
	}
}

resource "google_compute_instance" "gcp_instance_docker_server" {

	depends_on = [
		google_sql_database_instance.mysql,
		google_compute_router_nat.gcp-vpc-nat-router-nat-service
	]
	
	project				= "${google_compute_network.gcp_vpc_network.project}"
	zone				= "${var.zone}"
	name				= "${local.docker-server-vm-name}"
	description			= "${local.docker-server-description}"
	machine_type			= "${var.vm-machine-type}"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = "${local.docker-server-tags}"
	labels = "${local.docker-server-labels}"
	service_account {
		email  = google_service_account.application-server-service-account.email
		scopes = ["cloud-platform"]
	}
	boot_disk {
		auto_delete	= true
		device_name	= "${local.docker-server-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.docker-server-disk-size-gb
			type	= "${var.vm-boot-disk-type}"
			image	= "${local.docker-server-vm-boot-disk-image}"
		}
	}
	network_interface {
		network 		= "${local.docker-server-network-name}"
		subnetwork 		= "${local.docker-server-subnetwork-name}"
		subnetwork_project 	= "${var.project}"
		network_ip		= "${local.docker-server-network-ip}"
		stack_type		= "IPV4_ONLY"
	}
	shielded_instance_config {
		enable_secure_boot		= true
		enable_vtpm			= true
		enable_integrity_monitoring	= true
	}
	metadata = {
		# We enable OS Login and OS Config at the Project Level
		# enable-oslogin	= "TRUE"
		# enable-oslogin-2fa	= "TRUE"
		# We do not need to pass the public key when using OS Login
		# ssh-keys 		= "${var.ssh-username}:${file(var.ssh-public-key-file)}"
		startup-script	= "${var.vm-metadata-startup-script}"
		user-data 	= "${data.cloudinit_config.docker_server_configuration.rendered}"
 	}
} // end resource "google_compute_instance" "gcp_instance_docker_server"

output "docker-server-cpu-platform" {
	value 		= "${google_compute_instance.gcp_instance_docker_server.cpu_platform}"
	description	= "The CPU platform used by this instance"
}

output "docker-server-internal-ip-address" {
	value 		= "${google_compute_instance.gcp_instance_docker_server.network_interface.0.network_ip}"
	description	= "The internal ip address of the instance, either manually or dynamically assigned"
}

output "docker-server-external-ip-address" {
	  value = length(google_compute_instance.gcp_instance_docker_server.network_interface.0.access_config.*.nat_ip) > 0 ? google_compute_instance.gcp_instance_docker_server.network_interface.0.access_config.*.nat_ip : null
	description	= "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip"
}


