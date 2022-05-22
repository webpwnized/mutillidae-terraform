
resource "google_compute_firewall" "allow-egress-utility-server-to-internet" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-egress-utility-server-to-internet"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow HTTP, HTTPS traffic leaving the ${google_compute_network.gcp_vpc_network.name} network"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.http-port}","${var.https-port}"]
	}

	target_tags		= ["utility-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}
