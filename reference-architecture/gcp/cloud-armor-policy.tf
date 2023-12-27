
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy
# https://cloud.google.com/armor/docs/configure-security-policies
# https://cloud.google.com/armor/docs/rules-language-reference
# https://cloud.google.com/armor/docs/rule-tuning#crs-3.3
# https://cloud.google.com/armor/quotas
# https://cloud.google.com/armor/docs/request-logging

# 	Filter: jsonPayload.enforcedSecurityPolicy.outcome="DENY"
#	Filter: jsonPayload.remoteIp="<YOUR IP ADDRESS>"
#	Search for: preconfiguredExprIds
#	Example exceptions: evaluatePreconfiguredExpr('sqli-v33-stable', ['owasp-crs-v030301-id942251-sqli', 'owasp-crs-v030301-id942490-sqli', 'owasp-crs-v030301-id942420-sqli', 'owasp-crs-v030301-id942431-sqli', 'owasp-crs-v030301-id942460-sqli', 'owasp-crs-v030301-id942101-sqli', 'owasp-crs-v030301-id942511-sqli', 'owasp-crs-v030301-id942421-sqli', 'owasp-crs-v030301-id942432-sqli', 'owasp-crs-v030301-id942330-sqli', 'owasp-crs-v030301-id942300-sqli', 'owasp-crs-v030301-id942310-sqli', 'owasp-crs-v030301-id942340-sqli', 'owasp-crs-v030301-id942370-sqli', 'owasp-crs-v030301-id942430-sqli', 'owasp-crs-v030301-id942440-sqli', 'owasp-crs-v030301-id942110-sqli'])
#	Example Exceptions: evaluatePreconfiguredExpr('xss-v33-stable', ['owasp-crs-v030301-id941330-xss', 'owasp-crs-v030301-id941340-xss'])
#	Example Exceptions: evaluatePreconfiguredExpr('protocolattack-v33-stable', ['owasp-crs-v030301-id921150-protocolattack', 'owasp-crs-v030301-id921120-protocolattack'])


# GCP imposes restrictions on policies
# 10 security policies per project
# 200 security rules per project across all security policies
# 20 rules with an advanced match condition across all security policies per project

locals {
	security-policy-project		= "${google_compute_network.gcp_vpc_network.project}"
	security-policy-name		= "${google_compute_network.gcp_vpc_network.name}-security-policy"
	security-policy-description	= "Cloud Armor security policy"

	# Example of excluding specific rules in a policy if a specific rule causes an issue
	# security-policy-owasp-rules-1	= "evaluatePreconfiguredExpr('sqli-v33-stable', ['owasp-crs-v030301-id942330-sqli', 'owasp-crs-v030301-id942421-sqli', 'owasp-crs-v030301-id942432-sqli', 'owasp-crs-v030301-id942110-sqli', 'owasp-crs-v030301-id942420-sqli']) || evaluatePreconfiguredExpr('xss-v33-stable', ['owasp-crs-v030301-id941330-xss']) || evaluatePreconfiguredExpr('lfi-v33-stable') || evaluatePreconfiguredExpr('rfi-v33-stable') || evaluatePreconfiguredExpr('rce-v33-stable')"
	
	security-policy-owasp-rules-1	= "evaluatePreconfiguredExpr('sqli-v33-stable', ['owasp-crs-v030301-id942330-sqli','owasp-crs-v030301-id942421-sqli']) || evaluatePreconfiguredExpr('xss-v33-stable') || evaluatePreconfiguredExpr('lfi-v33-stable') || evaluatePreconfiguredExpr('rfi-v33-stable') || evaluatePreconfiguredExpr('rce-v33-stable')"

	security-policy-owasp-rules-2	= "evaluatePreconfiguredExpr('protocolattack-v33-stable') || evaluatePreconfiguredExpr('php-v33-stable') || evaluatePreconfiguredExpr('sessionfixation-v33-stable') || evaluatePreconfiguredExpr('java-v33-stable') || evaluatePreconfiguredExpr('nodejs-v33-stable')"

	security-policy-owasp-rules-3	= "evaluatePreconfiguredExpr('cve-canary') || evaluatePreconfiguredExpr('methodenforcement-v33-stable') || evaluatePreconfiguredExpr('scannerdetection-v33-stable') || evaluatePreconfiguredExpr('json-sqli-canary')"
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
				expression = "${local.security-policy-owasp-rules-1}"
			}
		}
	}

	rule {
		description	= "Block access if OWASP rule triggered"
		action		= "deny(403)"
		priority	= "1001"
		match {
			expr {
				expression = "${local.security-policy-owasp-rules-2}"
			}
		}
	}
	
	rule {
		description	= "Block access if OWASP rule triggered"
		action		= "deny(403)"
		priority	= "1002"
		match {
			expr {
				expression = "${local.security-policy-owasp-rules-3}"
			}
		}
	}
	
	rule {
		description	= "Allow access to Load Balancer from office"
		action		= "allow"
		priority	= "1003"
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
