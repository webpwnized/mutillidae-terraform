
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

variable "default-labels" { 
	type = map(string)
	default = {
		owner: "jeremy-druin",
		environment: "testnet",
		application: "mutillidae"
	} 
}

variable "admin-office-ip-address-range" {
	type = list(string)
	default = ["104.0.151.118/32"]
}

variable "gcp-iap-ip-address-range" {
	type = list(string)
	default = ["35.235.240.0/20"]
}

variable "ssh-port" {
	type = string
	default = "22"
}

variable "http-port" {
	type = string
	default = "80"
}

variable "mysql-admin-http-port" {
	type = string
	default = "81"
}

variable "ldap-admin-http-port" {
	type = string
	default = "82"
}

variable "vm-machine-type" {
	type = string
	default = "e2-small"
}

variable "vm-boot-disk-type" {
	type = string
	default = "pd-standard"
}

variable "vm-boot-disk-image" {
	type = string
	default = "ubuntu-os-cloud/ubuntu-2110"
}

variable "vm-metadata-startup-script" {
	type = string
	default = "#! /bin/bash\n# Google runs these commands as root user\napt update\napt upgrade -y\napt autoremove -y"
}


