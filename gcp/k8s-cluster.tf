
locals {
	gke-cluster-project	= var.project
	gke-cluster-location	= var.zone
	gke-cluster-network	= "${google_compute_subnetwork.gcp_vpc_k8s_subnetwork.network}"
	gke-cluster-subnetwork	= "${google_compute_subnetwork.gcp_vpc_k8s_subnetwork.name}"

	gke-cluster-name 	= "mutillidae-gke-cluster"
	gke-cluster-description	= "A GKE Cluster to run Docker containers"

	gke-node-image-type 		= "COS_CONTAINERD"
	gke-node-disk-size-gb		= 25
	gke-node-initial-node-count	= 1
	gke-node-min-node-count		= 1
	gke-node-max-node-count		= 3
}

resource "google_container_cluster" "gke_cluster" {
	project		= "${local.gke-cluster-project}"
	location	= "${local.gke-cluster-location}"
	network		= "${local.gke-cluster-network}"
	subnetwork	= "${local.gke-cluster-subnetwork}"
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
}

resource "google_container_node_pool" "gke_cluster_nodes" {
	project			= "${google_container_cluster.gke_cluster.project}"
	name			= "${google_container_cluster.gke_cluster.name}-node-pool"
	cluster			= "${google_container_cluster.gke_cluster.name}"
	location		= "${google_container_cluster.gke_cluster.location}"
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
		image_type 		= "${local.gke-node-image-type}"
		machine_type		= "${var.vm-machine-type}"
		disk_size_gb	= local.gke-node-disk-size-gb
		disk_type 	= "${var.vm-boot-disk-type}"
		shielded_instance_config {
			enable_secure_boot		= true
			enable_integrity_monitoring	= true
		}
	}
}

