
resource "google_compute_firewall" "allow-ingress-ssh-iap-to-application-server" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-ssh-iap-to-application-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow SSH to application host when using Identity Aware Proxy to tunnel traffic from the Internet"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.ssh-port}"]
	}

	source_ranges	= var.gcp-iap-ip-address-range
	target_tags	= ["web-server"]

	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-ingress-http-bastion-host-to-application-server" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-http-bastion-host-to-application-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow HTTP from bastion host to application server"
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

resource "google_compute_firewall" "allow-ingress-icmp-bastion-host-to-application-server" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-icmp-bastion-host-to-application-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow ICMP from bastion host to application server"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "icmp"
	}

	source_tags	= ["bastion-host"]
	target_tags	= ["web-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-ingress-web-health-check-to-application-server" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-web-health-check-to-application-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow health checks to application host"
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

