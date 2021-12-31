
locals {
	docker-server-project		= "${google_compute_network.gcp_vpc_network.project}"
	docker-server-region		= "${var.region}"
	docker-server-zone		= "${var.zone}"
	docker-server-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	docker-server-subnetwork-name	= "${google_compute_subnetwork.gcp_vpc_iaas_subnetwork.name}"
	
	//Make sure these are set for this machine
	docker-server-vm-name		= "docker-server-vm"
	docker-server-network-ip		= "10.0.0.5"
	docker-server-tags 		= ["docker-server","web-server"]
	docker-server-disk-size-gb	= 25
	docker-server-description		= "A docker server to run containers on the ${local.docker-server-subnetwork-name} subnet"

	docker-server-labels 		= "${merge(
						tomap({ 
							"purpose"	= "application-server",
							"asset-type"	= "virtual-machine"
						}),
						var.default-labels)
					}"
	docker-server-cloud-init-config-file	= "docker-server.cloud-init.yaml"
}

data "cloudinit_config" "docker_server_configuration" {
	gzip = false
	base64_encode = false

	part {
		content_type = "text/cloud-config"
		content = templatefile("${local.docker-server-cloud-init-config-file}",
			{
				username	= "${var.gcp-ssh-username}"
				ssh-public-key	= "${file(var.gcp-ssh-public-key-file)}"
			}
		)
		filename = "${local.docker-server-cloud-init-config-file}"
	}
}

resource "google_compute_instance" "gcp_instance_docker_server" {
	project				= "${local.docker-server-project}"
	zone				= "${local.docker-server-zone}"
	name				= "${local.docker-server-vm-name}"
	description			= "${local.docker-server-description}"
	machine_type			= "${var.vm-machine-type}"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = "${local.docker-server-tags}"
	labels = "${local.docker-server-labels}"
	boot_disk {
		auto_delete	= true
		device_name	= "${local.docker-server-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.docker-server-disk-size-gb
			type	= "${var.vm-boot-disk-type}"
			image	= "${var.vm-boot-disk-image}"
		}
	}
	network_interface {
		network 		= "${local.docker-server-network-name}"
		subnetwork 		= "${local.docker-server-subnetwork-name}"
		subnetwork_project 	= "${local.docker-server-project}"
		network_ip		= "${local.docker-server-network-ip}"
		stack_type		= "IPV4_ONLY"
		access_config{
			network_tier	= "STANDARD"
		}
	}
	shielded_instance_config {
		enable_secure_boot		= true
		enable_vtpm			= true
		enable_integrity_monitoring	= true
	}
	metadata = {
		ssh-keys = "${var.gcp-ssh-username}:${file(var.gcp-ssh-public-key-file)}"
		startup-script	= "${var.vm-metadata-startup-script}"
		user-data = "${data.cloudinit_config.docker_server_configuration.rendered}"
 	}
} // end resource "google_compute_instance" "gcp_instance_docker_server"

