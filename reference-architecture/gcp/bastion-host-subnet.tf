
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

locals {
	bastion-host-subnet-project	= "${google_compute_network.gcp_vpc_network.project}"
	bastion-host-subnet-region	= "${var.region}"
	bastion-host-subnet-network	= "${google_compute_network.gcp_vpc_network.name}"
	bastion-host-subnet-name	= "bastion-host-subnet"
	bastion-host-subnet-description	= "VPC subnet to deploy bastion hosts"
	
	bastion-host-subnet-ip-address-range	= "${var.bastion-host-subnet-ip-address-range}"
}

resource "google_compute_subnetwork" "gcp-vpc-bastion-host-subnetwork" {
	project		= "${local.bastion-host-subnet-project}"
	region		= "${local.bastion-host-subnet-region}"
	network		= "${local.bastion-host-subnet-network}"
	name		= "${local.bastion-host-subnet-name}"
	description	= "${local.bastion-host-subnet-description}"

	ip_cidr_range	= "${local.bastion-host-subnet-ip-address-range}"
	private_ip_google_access	= "true"
	
	log_config {
		aggregation_interval	= "INTERVAL_5_SEC"
		flow_sampling		= "0.25"
		metadata		= "INCLUDE_ALL_METADATA"
		filter_expr		= "true"
	}
}

output "bastion-host-subnetwork-gateway-address" {
	value 		= "${google_compute_subnetwork.gcp-vpc-bastion-host-subnetwork.gateway_address}"
	description	= "The gateway address for default routes to reach destination addresses outside this subnetwork"
}

