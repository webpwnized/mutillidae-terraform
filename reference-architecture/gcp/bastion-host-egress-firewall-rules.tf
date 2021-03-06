
resource "google_compute_firewall" "allow-egress-ssh-from-bastion-host" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-egress-ssh-from-bastion-host"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow SSH traffic leaving the bastion host"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.ssh-port}"]
	}

	target_tags		= ["bastion-host"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-egress-web-from-bastion-host" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-egress-internet-from-bastion-host"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow HTTP, HTTPS traffic leaving the bastion host"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.http-port}","${var.https-port}"]
	}

	target_tags		= ["bastion-host"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}
