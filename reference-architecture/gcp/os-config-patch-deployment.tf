
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/os_config_patch_deployment

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
			hours	= 2	# 3:00 AM Eastern Time
		}
	}
}

#resource "google_os_config_patch_deployment" "one-time-patch-deployment" {
#
#	patch_deployment_id = "iaas-one-time-patch-deployment"
#
#	instance_filter {
#		all	= true
#	}
#
#	# Example of one time schedule in case immediate patch needed. Cannot be used at same time as recurring_schedule
#	one_time_schedule {
#		execute_time	= "2022-11-15T23:05:00Z"
#	}
#}
