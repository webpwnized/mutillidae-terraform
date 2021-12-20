
// Variables
variable "project" {
  type = string
  default = "concise-display-321523"
}

variable "terraform-credentials-file" {
  type = string
  default = "/home/jeremy/.creds/terraform-service-account-key.json"
}

variable "gcp-ssh-username" {
  type = string
  default = "/home/jeremy/.ssh/gcp-mutillidae-app-server-1.pub"
}

variable "gcp-ssh-public-key-file" {
  type = string
  default = "/home/jeremy/.ssh/gcp-mutillidae-app-server-1.pub"
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "zone" {
  type = string
  default = "us-central1-a"
}
