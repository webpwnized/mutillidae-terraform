# Mutillidae Terraform Google Cloud Platform Lab Environment

This project contains reference architectures for Google Cloud Platform (GCP) and Microsoft Azure Cloud. The project also contains scripts to generate a deliberately insecure lab environment. The lab environment can be used for demonstrations and in classwork.

## Dependencies

### This project
`git clone https://github.com/webpwnized/mutillidae-terraform.git`

### Terrform client software
`sudo apt get install terraform`

### The Google Cloud Platform (GPC) *gcloud* client software

Follow [**the instructions for your distribution**](https://cloud.google.com/sdk/docs/install#linux "the instructions for your distribution")

### A Google Cloud Platform (GPC) project

[How to Create a Project in Google Cloud Platform (GPC)](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)")

### A Google Cloud Platform (GCP) Service Account for Terraform

[How to Create a Service Account for Terraform](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform")

## Installation Instructions

1. Clone this project
2. The project lab files includes ***variables.tf.CHANGEME***. Rename the file ***variables.tf***.
3. Create an SSH key pair. You will use the SSH public key to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. [**Create and SSH key pair**](https://www.youtube.com/watch?v=eUwOlc9HfZs "Linux Basics: How to Create SSH Key"). Put the full path to the public key in the ***variables.tf*** file.
4. Configure the variables in the ***variables.tf*** file at the root of this project
5. Install, initialize, and authenticate the Google ***gcloud*** client software following [**the instructions for your distribution**](https://cloud.google.com/sdk/docs/install#linux "the instructions for your distribution")
6. Install the ***terraform*** client software 
7. [**Create a project**](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)") in Google Cloud Platform (GCP). Configure the project name in the ***variables.tf*** file.
8. [**Create a service account**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the Google Cloud Platform (GCP) project
9. [**Create a service account key**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") for the service account
10. Place the service account key in a file. [**Configure the service account key location**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the ***variables.tf*** file.
11. Deploy the lab

### How to configure variables.tf

1. ***terraform-credentials-file*** - The GCP service account that Terraform will use to authenticate to the project. [**Create a service account key**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") for the service account. Place the service account key in a file. [**Configure the service account key location**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the ***variables.tf*** file.

2. ***project*** - The GCP project in which the assets will be built. [**Create a project**](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)") in Google Cloud Platform (GCP). Configure the project name in the ***variables.tf*** file.

3. ***ssh-username*** - The Linux username you will use to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. Configure the Linux user name in the ***variables.tf*** file.

4. ***ssh-public-key-file*** - The SSH public key you will use to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. [**Create and SSH key pair**](https://www.youtube.com/watch?v=eUwOlc9HfZs "Linux Basics: How to Create SSH Key"). Put the full path to the ***public key*** (not the private key) in the ***variables.tf*** file.

5. ***default-labels*** - Put your name in the "owner" field in the ***variables.tf*** file.

6. ***admin-office-ip-address-range*** - Your IP address. Terraform will set up firewall rules allowing access from this range. Put the full path to the public key in the ***variables.tf*** file.

### How to deploy the lab

`./deploy-gcp-lab-environment.sh`

