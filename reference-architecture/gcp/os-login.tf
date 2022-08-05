# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/os_login_ssh_public_key

# This file only works if you are using your personal account to authenticate Terraform. Since you
# should use a Service Account for Terraform, this file is generally not helpful

#resource "google_os_login_ssh_public_key" "os_login_ssh_public_key" {#
#	project	= "${google_compute_network.gcp_vpc_network.project}"
#	user 	= "${var.os-login-email-account}"
#	key 	= "${file(var.ssh-public-key-file)}"
#}

#output "os-login-username" {
#	value 		= "${google_os_login_ssh_public_key.os_login_ssh_public_key.user}"
#	description	= "The OS Login user account"
#}

