
// Configure the Google Cloud provider
provider "google" {
	credentials	= file("${var.terraform-credentials-file}")
	project		= "${var.project}"
	region		= "${var.region}"
	zone		= "${var.zone}"
}

provider "google-beta" {
	credentials	= file("${var.terraform-credentials-file}")
	project		= "${var.project}"
	region		= "${var.region}"
	zone		= "${var.zone}"
}

terraform {
	required_providers {
		random = {
			source = "hashicorp/random"
		}
	}
}

