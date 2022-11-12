# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block

terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
		}
	}
}

provider "aws" {
	shared_config_files		= ["${var.terraform-configuration-file}"]
	shared_credentials_files	= ["${var.terraform-credentials-file}"]
	region				= "${var.region}"
	allowed_account_ids		= ["${var.terraform-service-account-id}"]
	insecure			= "false"
	max_retries			= 25
		
	default_tags {
		tags = {
			owner 		= "${var.default-tag-owner}"
			application 	= "${var.default-tag-application}"
			environment 	= "${var.default-tag-environment}"
		}
	}
}


