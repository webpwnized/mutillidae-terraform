
resource "google_compute_firewall" "allow-egress-web-from-bastion-host" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-egress-web-from-bastion-host"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow HTTP, HTTPS traffic leaving the bastion host"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 1001

	allow {
		protocol	= "tcp"
		ports		= ["${var.http-port}","${var.https-port}"]
	}

	target_tags		= ["bastion-host"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-egress-icmp-from-bastion-host" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-egress-icmp-from-bastion-host"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow ICMP traffic leaving the bastion host"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 1002

	allow {
		protocol	= "icmp"
	}

	target_tags		= ["bastion-host"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}
