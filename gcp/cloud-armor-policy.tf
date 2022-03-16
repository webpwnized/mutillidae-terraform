
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy
# https://cloud.google.com/armor/docs/configure-security-policies
# https://cloud.google.com/armor/docs/rules-language-reference

locals {
	security-policy-project	= "${google_compute_network.gcp_vpc_network.project}"
	security-policy-name		= "${google_compute_network.gcp_vpc_network.name}-security-policy"
	security-policy-description	= "Cloud Armor security policy"
}

resource "google_compute_security_policy" "security-policy" {
	project		= "${local.security-policy-project}"
	name		= "${local.security-policy-name}"
	description	= "${local.security-policy-description}"

	rule {
		description	= "Block access if OWASP rule triggered"
		action		= "deny(403)"
		priority	= "1000"
		match {
			expr {
				expression = "evaluatePreconfiguredExpr('sqli-stable', ['owasp-crs-v030001-id942421-sqli']) || evaluatePreconfiguredExpr('xss-stable') || evaluatePreconfiguredExpr('lfi-stable') || evaluatePreconfiguredExpr('rfi-stable') || evaluatePreconfiguredExpr('rce-stable')"
			}
		}
	}

	rule {
		description	= "Allow access to Load Balancer from office"
		action		= "allow"
		priority	= "1001"
		match {
			versioned_expr	= "SRC_IPS_V1"
			config {
				src_ip_ranges	= "${var.admin-office-ip-address-range}"
			}
		}
	}

	rule {
		description	= "Default rule. Deny all access to Load Balancer"
		action		= "deny(403)"
		priority	= "2147483647"
		match {
			versioned_expr	= "SRC_IPS_V1"
			config {
				src_ip_ranges	= ["*"]
			}
		}
	}

}
