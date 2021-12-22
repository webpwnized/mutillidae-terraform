output "docker_host_output" {
	value 	= "Provisioning ${google_compute_instance.gcp_instance_docker_host.name}"
}

output "cloud_init_output" {
	value 	= "cloud-init script: ${data.cloudinit_config.configuration.rendered}"
}

