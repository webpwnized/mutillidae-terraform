
resource "google_compute_firewall" "allow-egress-docker-server-to-mysql-server" {
	project		= "${local.egress-firewall-project}"
	name		= "${google_compute_network.gcp_vpc_network.name}-allow-egress-docker-server-to-mysql-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow MySql connection from docker server to mysql server"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.mysql-port}"]
	}

	target_tags		= ["docker-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-egress-docker-server-to-internet" {
	project		= "${local.egress-firewall-project}"
	name		= "allow-egress-docker-server-to-internet"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow HTTP, HTTPS traffic leaving the ${google_compute_network.gcp_vpc_network.name} network"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.http-port}","${var.https-port}"]
	}

	target_tags		= ["docker-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}
