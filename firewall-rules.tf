
locals {
	firewall-project	= "${google_compute_network.gcp_vpc_network.project}"
	firewall-region		= "${var.region}"
	firewall-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	firewall-rule-1-name	= "${local.firewall-network-name}-allow-ssh-to-bastion-host-from-iap"
	firewall-rule-2-name	= "${local.firewall-network-name}-allow-ssh-to-docker-host-from-bastion-host"
	firewall-rule-3-name	= "${local.firewall-network-name}-allow-http-to-docker-host-from-internet"
}

resource "google_compute_firewall" "allow-ssh-to-bastion-host-from-iap" {
	project		= "${local.firewall-project}"
	name		= "${local.firewall-rule-1-name}"
	network 	= "${local.firewall-network-name}"
	description	= "Allow SSH to bastion host when using Identity Aware Proxy to tunnel traffic within the ${local.firewall-network-name} network"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["22"]
	}

	source_ranges	= ["35.235.240.0/20"]
	target_tags	= ["bastion-host"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-ssh-to-docker-host-from-bastion-host" {
	project		= "${local.firewall-project}"
	name		= "${local.firewall-rule-2-name}"
	network 	= "${local.firewall-network-name}"
	description	= "Allow SSH to docker host from the bastion host in the ${local.firewall-network-name} network"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["22"]
	}

	source_ranges	= ["bastion-host"]
	target_tags	= ["docker-host"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-http-to-docker-host-from-internet" {
	project		= "${local.firewall-project}"
	name		= "${local.firewall-rule-3-name}"
	network 	= "${local.firewall-network-name}"
	description	= "Allow HTTP to docker host from the Internet"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["80","81","82"]
	}

	source_ranges	= ["0.0.0.0/0"]
	target_tags	= ["docker-host"]
	
	log_config {
		metadata	= "EXCLUDE_ALL_METADATA"
	}
}
