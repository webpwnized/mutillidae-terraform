
resource "google_compute_firewall" "allow-ingress-ssh-bastion-host-to-docker-server" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-ssh-bastion-host-to-docker-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow SSH from bastion host to docker server"
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

resource "google_compute_firewall" "allow-ingress-http-bastion-host-to-docker-server" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-http-bastion-host-to-docker-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow HTTP from bastion host to docker server"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.mutillidae-http-port}","${var.mysql-admin-http-port}","${var.ldap-admin-http-port}"]
	}

	source_tags	= ["bastion-host"]
	target_tags	= ["web-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-ingress-web-health-check-to-docker-server" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-web-health-check-to-docker-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
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

