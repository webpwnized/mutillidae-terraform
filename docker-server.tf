
locals {
	docker-host-project		= "${google_compute_network.gcp_vpc_network.project}"
	docker-host-region		= "${var.region}"
	docker-host-zone		= "${var.zone}"
	docker-host-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	docker-host-subnetwork-name	= "${google_compute_subnetwork.gcp_vpc_iaas_subnetwork.name}"
	docker-host-ssh-username	= "${var.gcp-ssh-username}"
	docker-host-ssh-public-key-file	= "${var.gcp-ssh-public-key-file}"
	
	//Make sure these are set for this machine
	docker-host-vm-name		= "docker-host-vm-t"
	docker-host-image		= "ubuntu-os-cloud/ubuntu-2110"
	docker-host-network-ip		= "10.0.0.5"
	docker-host-tags 		= ["docker-host","web-server"]
	docker-host-disk-size-gb	= 25 //GB
	docker-host-description		= "A docker server to run containers on the ${local.docker-host-subnetwork-name} subnet"

	docker-host-labels 		= "${merge(
						tomap({ 
							"purpose"	= "application-server",
							"asset-type"	= "virtual-machine"
						}),
						var.default_labels)
					}"
}

data "cloudinit_config" "docker_server_configuration" {
  gzip = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = file("docker-server.cloud-init.yaml")
    filename = "docker-server.cloud-init.conf"
  }
}

resource "google_compute_instance" "gcp_instance_docker_host" {
	project				= "${local.docker-host-project}"
	zone				= "${local.docker-host-zone}"
	name				= "${local.docker-host-vm-name}"
	description			= "${local.docker-host-description}"
	machine_type			= "e2-small"
	allow_stopping_for_update	= true
	can_ip_forward			= false
	tags = "${local.docker-host-tags}"
	labels = "${local.docker-host-labels}"
	boot_disk {
		auto_delete	= true
		device_name	= "${local.docker-host-vm-name}-disk"
		mode		= "READ_WRITE"
		initialize_params {
			size	= local.docker-host-disk-size-gb
			type	= "pd-standard"
			image	= "${local.docker-host-image}"
		}
	}
	network_interface {
		network 		= "${local.docker-host-network-name}"
		subnetwork 		= "${local.docker-host-subnetwork-name}"
		subnetwork_project 	= "${local.docker-host-project}"
		network_ip		= "${local.docker-host-network-ip}"
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
		ssh-keys = "${local.docker-host-ssh-username}:${file(local.docker-host-ssh-public-key-file)}"
		startup-script	= "#! /bin/bash\n# Google runs these commands as root user\napt update\napt upgrade -y"
		user-data = "${data.cloudinit_config.docker_server_configuration.rendered}"
 	}
} // end resource "google_compute_instance" "gcp_instance_docker_host"

