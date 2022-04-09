
resource "google_compute_firewall" "allow-egress-docker-server-to-mysql-server" {
	project		= "${local.egress-firewall-project}"
	name		= "${local.egress-firewall-network-name}-allow-egress-docker-server-to-mysql-server"
	network 	= "${local.egress-firewall-network-name}"
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
