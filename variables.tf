
variable "project" {
	type = string
	default = "concise-display-321523"
}

variable "terraform-credentials-file" {
	type = string
	default = "/home/jeremy/.creds/terraform-service-account-key.json"
}

variable "region" {
	type = string
	default = "us-central1"
}

variable "zone" {
	type = string
	default = "us-central1-a"
}

variable "gcp-ssh-username" {
	type = string
	default = "jeremy"
}

variable "gcp-ssh-public-key-file" {
	type = string
	default = "/home/jeremy/.ssh/gcp-mutillidae-app-server-1.pub"
}

variable "gcp-ssh-private-key-secret" {
	type = string
	default = "gcp-iaas-server-ssh-private-key"
}

variable "default_labels" { 
	type = map(string)
	default = {
		owner: "jeremy-druin",
		environment: "testnet",
		application: "mutillidae"
	} 
}

variable "admin_office_ip_address_range" {
	type = list(string)
	default = ["104.0.151.118/32"]
}

variable "gcp_iap_ip_address_range" {
	type = list(string)
	default = ["35.235.240.0/20"]
}

variable "ssh_port" {
	type = string
	default = "22"
}

variable "http_port" {
	type = string
	default = "80"
}

variable "mysql_admin_http_port" {
	type = string
	default = "81"
}

variable "ldap_admin_http_port" {
	type = string
	default = "82"
}

variable "vm_machine_type" {
	type = string
	default = "e2-small"
}

variable "vm_boot_disk_type" {
	type = string
	default = "pd-standard"
}

variable "vm_boot_disk_image" {
	type = string
	default = "ubuntu-os-cloud/ubuntu-2110"
}

variable "vm-metadata-startup-script" {
	type = string
	default = "#! /bin/bash\n# Google runs these commands as root user\napt update\napt upgrade -y\napt autoremove -y"
}


