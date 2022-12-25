
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat

locals {
	nat-router-project	= "${google_compute_network.gcp_vpc_network.project}"
	nat-router-region	= "${var.region}"
	nat-router-network	= "${google_compute_network.gcp_vpc_network.name}"
	nat-router-name		= "${google_compute_network.gcp_vpc_network.name}-nat-router"
	nat-service-name	= "${google_compute_router.gcp-vpc-nat-router.name}-nat-service"
}

resource "google_compute_router" "gcp-vpc-nat-router" {
	project		= "${local.nat-router-project}"
	region  	= "${local.nat-router-region}"
	network 	= "${local.nat-router-network}"
	name		= "${local.nat-router-name}"
	description	= "NAT router to proxy egress traffic outbound for the ${local.nat-router-network} network"
}

resource "google_compute_router_nat" "gcp-vpc-nat-router-nat-service" {
	depends_on 				= [google_compute_router.gcp-vpc-nat-router]
	project					= "${local.nat-router-project}"
	region  				= "${local.nat-router-region}"
	router					= "${local.nat-router-name}"
	name					= "${local.nat-service-name}"
	nat_ip_allocate_option			= "AUTO_ONLY"
	source_subnetwork_ip_ranges_to_nat	= "LIST_OF_SUBNETWORKS"
	
	subnetwork {
		name			= "${google_compute_subnetwork.gcp-vpc-bastion-host-subnetwork.name}"
		source_ip_ranges_to_nat	= ["PRIMARY_IP_RANGE"]
	}

	subnetwork {
		name			= "${google_compute_subnetwork.gcp-vpc-application-server-subnetwork.name}"
		source_ip_ranges_to_nat	= ["PRIMARY_IP_RANGE"]
	}

	log_config {
		enable = true
		filter = "ALL"
	}
}

