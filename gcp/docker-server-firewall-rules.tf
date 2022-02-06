locals {
	docker-server-firewall-project		= "${google_compute_network.gcp_vpc_network.project}"
	docker-server-firewall-region		= "${var.region}"
	docker-server-firewall-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	docker-server-firewall-rule-2-name	= "${local.docker-server-firewall-network-name}-allow-ssh-to-docker-server-from-bastion-host"
	docker-server-firewall-rule-3-name	= "${local.docker-server-firewall-network-name}-allow-http-to-docker-server-from-internet"
}

resource "google_compute_firewall" "allow-ssh-to-docker-server-from-bastion-host" {
	project		= "${local.docker-server-firewall-project}"
	name		= "${local.docker-server-firewall-rule-2-name}"
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

resource "google_compute_firewall" "allow-http-to-docker-server-from-internet" {
	project		= "${local.docker-server-firewall-project}"
	name		= "${local.docker-server-firewall-rule-3-name}"
	network 	= "${local.docker-server-firewall-network-name}"
	description	= "Allow HTTP to docker host from the Internet"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.http-port}","${var.mysql-admin-http-port}","${var.ldap-admin-http-port}"]
	}

	source_ranges	= var.admin-office-ip-address-range
	target_tags	= ["web-server"]
	
	log_config {
		metadata	= "EXCLUDE_ALL_METADATA"
	}
}
