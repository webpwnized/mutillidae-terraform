
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group

locals {
	application-server-instance-group-project	= "${google_compute_network.gcp_vpc_network.project}"
	application-server-instance-group-network	= "${google_compute_network.gcp_vpc_network.id}"
	application-server-instance-group-name		= "${google_compute_network.gcp_vpc_network.name}-application-server-instance-group"
}

resource "google_compute_instance_group" "application-server-instance-group" {
	project		= "${local.application-server-instance-group-project}"
	network		= "${local.application-server-instance-group-network}"
	name		= "${local.application-server-instance-group-name}"
	zone		= "${var.zone}"
	description	= "The unmanaged instance group containing application servers"
	
	instances	= ["${google_compute_instance.gcp_instance_application_server.id}"]
	
	named_port{
		name	= "mutillidae-http-port"
		port	= "${var.mutillidae-http-port}"
	}
	named_port{
		name	= "mutillidae-https-port"
		port	= "${var.mutillidae-https-port}"
	}
	named_port{
		name	= "mysql-admin-http-port"
		port	= "${var.mysql-admin-http-port}"
	}
	named_port{
		name	= "ldap-admin-http-port"
		port	= "${var.ldap-admin-http-port}"
	}
}

output "application-server-instance-group-size" {
	value 		= "${google_compute_instance_group.application-server-instance-group.size}"
	description	= "The number of instances in the group"
}

