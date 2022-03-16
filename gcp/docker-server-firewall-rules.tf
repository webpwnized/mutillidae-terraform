locals {
	docker-server-firewall-project		= "${google_compute_network.gcp_vpc_network.project}"
	docker-server-firewall-region		= "${var.region}"
	docker-server-firewall-network-name	= "${google_compute_network.gcp_vpc_network.name}"
}

resource "google_compute_firewall" "allow-ssh-to-docker-server-from-bastion-host" {
	project		= "${local.docker-server-firewall-project}"
	name		= "allow-ssh-to-docker-server-from-bastion-host"
	network 	= "${local.docker-server-firewall-network-name}"
	description	= "Allow SSH to docker host from the bastion host in the ${local.docker-server-firewall-network-name} network"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= [var.ssh-port]
	}

	source_tags	= ["bastion-host"]
	target_tags	= ["docker-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-health-check-to-docker-server" {
	project		= "${local.docker-server-firewall-project}"
	name		= "allow-health-check-to-docker-server"
	network 	= "${local.docker-server-firewall-network-name}"
	description	= "Allow health checks to docker host"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.mutillidae-http-port}","${var.mysql-admin-http-port}","${var.ldap-admin-http-port}"]
	}

	source_ranges	= "${var.gcp-health-check-ip-address-range}"
	target_tags	= ["web-server"]
	
	log_config {
		metadata	= "EXCLUDE_ALL_METADATA"
	}
}

