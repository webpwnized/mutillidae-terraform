
locals {
	// Inherited attributes
	gke-cluster-project	= "${google_compute_subnetwork.gcp_vpc_k8s_subnetwork.project}"
	gke-cluster-location	= "${var.zone}"
	gke-cluster-network	= "${google_compute_subnetwork.gcp_vpc_k8s_subnetwork.network}"
	gke-cluster-subnetwork	= "${google_compute_subnetwork.gcp_vpc_k8s_subnetwork.name}"
	
	gke-cluster-name 	= "mutillidae-gke-cluster"
	gke-cluster-description	= "A GKE Cluster to run Docker containers"

	gke-node-image_type 		= "COS_CONTAINERD"
	gke-node-disk-size-gb		= 25
	gke-node-initial-node-count	= 1
	gke-node-min-node-count		= 1
	gke-node-max-node-count		= 3
}

resource "google_container_cluster" "gke_cluster" {
	project		= "${local.gke-cluster-project}"
	location	= "${var.zone}"
	network		= "${local.gke-cluster-network}"
	subnetwork	= "${local.gke-cluster-name}"
	name		= "${local.gke-cluster-name}"
	remove_default_node_pool	= true
	initial_node_count		= 1
	addons_config {
		horizontal_pod_autoscaling {
			disabled	= false
		}
		http_load_balancing {
			disabled	= false
		}
		network_policy_config {
			disabled	= false
		}
	}
	confidential_nodes {
		enabled		= true
	}
}

resource "google_container_node_pool" "gke_cluster_nodes" {
	project			= "${google_container_cluster.gke_cluster.project}"
	name			= "${google_container_cluster.gke_cluster.name}-node-pool"
	cluster			= "${google_container_cluster.gke_cluster.name}"
	location		= "${var.zone}"
	initial_node_count	= local.gke-node-initial-node-count
	autoscaling {
		min_node_count	= local.gke-node-min-node-count
		max_node_count	= local.gke-node-max-node-count		
	}
	management {
		auto_repair	= true
		auto_upgrade	= true
	}
	node_config {
		image_type 		= "${local.gke-node-image_type}"
		machine_type		= "${var.vm_machine_type}"
		disk_size_gb	= local.gke-node-disk-size-gb
		disk_type 	= "${var.vm_boot_disk_type}"
		shielded_instance_config {
			enable_secure_boot		= true
			enable_integrity_monitoring	= true
		}
	}
}

