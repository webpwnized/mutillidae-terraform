# Installation Instructions

## Dependencies

### An operating system to install the needed software

If you would like to use an Ubuntu virtual machine, [**install Ubuntu on VirtualBox**](https://www.youtube.com/watch?v=Cazzls2sZVk) or other hypervisor. Ubuntu runs better on VirtualBox if [**the Guest Additions are installed**](https://www.youtube.com/watch?v=8VCeFRwRmRU). If VirtualBox is not installed, [**install VirtualBox**](https://www.youtube.com/watch?v=61GhP8DsQMw).

### This project

`git clone https://github.com/webpwnized/mutillidae-terraform.git`

### Terrform client software

[**This video**](https://www.youtube.com/watch?v=LM3RLgNu7tU) shows [**how to install Terraform on Ubuntu Linux**](https://www.youtube.com/watch?v=LM3RLgNu7tU). Otherwise, follow the instructions for your distribution at the [**Hashicorp "Install Terraform" Developer Documentation**](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### The Google Cloud Platform (GPC) *gcloud* client software

[**This video**](https://www.youtube.com/watch?v=04GONi_U6zU) shows [**how to install the gcloud CLI on Ubuntu Linux**](https://www.youtube.com/watch?v=04GONi_U6zU). Otherwise, follow [**the instructions for your distribution**](https://cloud.google.com/sdk/docs/install#linux)

### The Azure Cloud *az* client software

The Azure az software is only needed for the Reference Architecture, but not the GCP lab.

[**This video**](https://www.youtube.com/watch?v=phJqcX-fcOw) shows [**how to install the Azure *az* CLI on Ubuntu Linux**](https://www.youtube.com/watch?v=phJqcX-fcOw). Otherwise, follow [**the instructions for your distribution**](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)

### The Amazon Web Services (AWS) *aws* client software

The Amazon Web Services (AWS) *aws* CLI client software is only needed for the Reference Architecture, but not the GCP lab.

[**This video**](https://www.youtube.com/watch?v=W7YFIzdxflc) shows [**how to install the Amazon Web Services (AWS) *aws* CLI client software on Ubuntu Linux**](https://www.youtube.com/watch?v=W7YFIzdxflc). Otherwise, follow [**the instructions for your distribution**](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### A Google Cloud Platform (GPC) project

This video shows [**how to Create a Project in Google Cloud Platform (GPC)**](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)")

### A Google Cloud Platform (GCP) Service Account for Terraform

This video shows [**how to Create a Service Account for Terraform**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform")

## Optional Pre-Installation Instructions

1. If you would like to use an Ubuntu virtual machine, [**install Ubuntu on VirtualBox**](https://www.youtube.com/watch?v=Cazzls2sZVk) or other hypervisor. 

2. Ubuntu runs better on VirtualBox if [**the Guest Additions are installed**](https://www.youtube.com/watch?v=8VCeFRwRmRU). 

3. If VirtualBox is not installed, [**install VirtualBox**](https://www.youtube.com/watch?v=61GhP8DsQMw).

## Installation Instructions

1. Clone this project

2. The lab files are located in this project within the ***mutillidae-terraform/lab-environment/gcp*** directory. The variables used by Terraform are inside the file ***variables.tf.CHANGEME***. Copy this file to a new file named ***variables.tf***. You will configure your variables in ***variables.tf***.

3. Create an SSH key pair. You will use the SSH public key to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. [**Create and SSH key pair**](https://www.youtube.com/watch?v=eUwOlc9HfZs "Linux Basics: How to Create SSH Key"). Put the full path to the public key in the ***variables.tf*** file.

4. Configure the variables in the ***variables.tf*** file at the root of this project. See instructions below in section ***How to configure variables.tf***.

5. Install, initialize, and authenticate the Google ***gcloud*** client software following [**the instructions for your distribution**](https://cloud.google.com/sdk/docs/install#linux "the instructions for your distribution")

6. [Install the ***terraform*** client software](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

7. [**Create a project**](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)") in Google Cloud Platform (GCP). Configure the project name in the ***variables.tf*** file.

8. [**Create a service account**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the Google Cloud Platform (GCP) project. The service account will need the following permissions.

* Editor Role

* Secret Manager Secret Accessor

* Service Networking  Admin



9. [**Create a service account key**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") for the service account

10. Place the service account key in a file. [**Configure the service account key location**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the ***variables.tf*** file.

11. Verify the following Google Cloud Platform (GCP) API are enabled for the Project

* Compute Engine API

* Cloud Resource Manager API

* Service Networking API

* Cloud SQL Admin API



12. Deploy the lab. See instructions below in section ***How to deploy the lab***.



### How to configure variables.tf



1. ***terraform-credentials-file*** - The GCP service account that Terraform will use to authenticate to the project. [**Create a service account key**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") for the service account. Place the service account key in a file. [**Configure the service account key location**](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform") in the ***variables.tf*** file.

2. ***project*** - The GCP project in which the assets will be built. [**Create a project**](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)") in Google Cloud Platform (GCP). Configure the project name in the ***variables.tf*** file.

3. ***ssh-username*** - The Linux username you will use to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. Configure the Linux user name in the ***variables.tf*** file.

4. ***ssh-public-key-file*** - The SSH public key you will use to authenticate to the IaaS bastion host via GCP Identity Aware Proxy and the Docker Host using SSH. [**Create and SSH key pair**](https://www.youtube.com/watch?v=eUwOlc9HfZs "Linux Basics: How to Create SSH Key"). Put the full path to the ***public key*** (not the private key) in the ***variables.tf*** file.

5. ***default-labels*** - Put your name in the "owner" field in the ***variables.tf*** file.

6. ***admin-office-ip-address-range*** - Your IP address. Terraform will set up firewall rules allowing access from this range. Put your IP address or IP address range into this value.

7. Using the above as examples, continue configuring the remaining variables
