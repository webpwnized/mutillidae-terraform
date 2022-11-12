
terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
		}
	}
}

provider "aws" {
	shared_config_files		= "${var.terraform-configuration-file}"
	shared_credentials_files	= "${var.terraform-credentials-file}"
	region				= "${var.region}"
	allowed_account_ids		= "[${var.terraform-service-account}]"
	default_tags			= var.default-tags
}


