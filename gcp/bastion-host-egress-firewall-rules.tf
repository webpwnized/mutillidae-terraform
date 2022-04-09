
resource "google_compute_firewall" "allow-egress-ssh-from-bastion-host" {
	project		= "${local.egress-firewall-project}"
	name		= "${local.egress-firewall-network-name}-allow-egress-ssh-from-bastion-host"
	network 	= "${local.egress-firewall-network-name}"
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

