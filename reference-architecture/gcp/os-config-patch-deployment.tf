
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/os_config_patch_deployment

# To test the deployment, go to GCP Console --> Patch Management --> Scheduled Jobs and start the job manually
resource "google_os_config_patch_deployment" "recurring-patch-deployment" {

	patch_deployment_id = "iaas-recurring-patch-deployment"

	instance_filter {
		all	= true
	}

	# There is only one recurring schedule allowed
	recurring_schedule {
		time_zone {
			id = "America/New_York"
		}

		time_of_day {
			hours	= 3	# 3:00 AM Eastern Time
		}
	}
}

