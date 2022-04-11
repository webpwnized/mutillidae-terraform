
locals {
	egress-firewall-project		= "${google_compute_network.gcp_vpc_network.project}"
	egress-firewall-region		= "${var.region}"
	egress-firewall-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	egress-firewall-rule-1-name	= "${local.egress-firewall-network-name}-deny-all-egress"
	egress-firewall-rule-1-description = "Deny all egress traffic leaving the ${local.egress-firewall-network-name} network"
	egress-firewall-rule-2-name	= "${local.egress-firewall-network-name}-allow-egress-http-https-to-internet"
	egress-firewall-rule-2-description = "Allow HTTP, HTTPS, NTP traffic leaving the ${local.egress-firewall-network-name} network"

}

resource "google_compute_firewall" "deny-all-egress" {
	project		= "${local.egress-firewall-project}"
	name		= "${local.egress-firewall-rule-1-name}"
	network 	= "${local.egress-firewall-network-name}"
	description	= "${local.egress-firewall-rule-1-description}"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 65533

	deny {
		protocol	= "all"
	}

	destination_ranges	= ["0.0.0.0/0"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-http-https-ntp-to-internet" {
	project		= "${local.egress-firewall-project}"
	name		= "${local.egress-firewall-rule-2-name}"
	network 	= "${local.egress-firewall-network-name}"
	description	= "${local.egress-firewall-rule-2-description}"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.http-port}","${var.https-port}","${var.ntp-port}"]
	}

	target_tags		= ["bastion-host","docker-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}





