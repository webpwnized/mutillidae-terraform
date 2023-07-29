# Bastion Host Reference Architecture

## The following files are used to create the reference Bastion Host for Google Cloud Platform (GCP)

- ***[network.tf](network.tf "network.tf")***
	- 3.1 Ensure That the Default Network Does Not Exist in a Project 
- ***[bastion-host-subnet.tf](bastion-host-subnet.tf "bastion-host-subnet.tf")***
	- 3.8 Ensure that VPC Flow Logs is Enabled for Every Subnet in a VPC Network
- ***[bastion-host.tf](bastion-host.tf "bastion-host.tf")***
	- 4.1 Ensure That Instances Are Not Configured To Use the Default Service Account
	- 4.2 Ensure That Instances Are Not Configured To Use the Default Service Account With Full Access to All Cloud APIs
	- 4.6 Ensure That IP Forwarding Is Not Enabled on Instances
	- 4.8 Ensure Compute Instances Are Launched With Shielded VM Enabled
	- 4.9 Ensure That Compute Instances Do Not Have Public IP Addresses
- ***[bastion-host-ingress-firewall-rules.tf](bastion-host-ingress-firewall-rules.tf "bastion-host-ingress-firewall-rules.tf")***
	- 3.6 Ensure That SSH Access Is Restricted From the Internet
	- 3.7 Ensure That RDP Access Is Restricted From the Internet
	- 3.10 Use Identity Aware Proxy (IAP) to Ensure Only Traffic From Google IP Addresses are 'Allowed'
- ***[bastion-host-egress-firewall-rules.tf](bastion-host-egress-firewall-rules.tf "bastion-host-egress-firewall-rules.tf")***
	- Blocks all outbound traffic except what is needed to reach patch update servers
- ***[bastion-host-service-account.tf](bastion-host-service-account.tf "bastion-host-service-account.tf")***
	- 4.1 Ensure That Instances Are Not Configured To Use the Default Service Account
	- 4.2 Ensure That Instances Are Not Configured To Use the Default Service Account With Full Access to All 
- ***[project-metadata.tf](project-metadata.tf "project-metadata.tf")***
	- 4.3 Ensure “Block Project-Wide SSH Keys” Is Enabled for VM Instances
	- 4.4 Ensure Oslogin Is Enabled for a Project
	- 4.5 Ensure ‘Enable Connecting to Serial Ports’ Is Not Enabled for VM Instance
- ***[project-services.tf](project-services.tf "project-services.tf")***
	- Enables OS Config Management services to support automated patching
- ***[os-config-patch-deployment.tf](os-config-patch-deployment.tf "os-config-patch-deployment.tf")***
	- 4.12 Ensure the Latest Operating System Updates Are Installed On Your Virtual Machines in All Projects
- ***[nat-router.tf](nat-router.tf "nat-router.tf")***
	- Facilitates traffic needed to reach patch update servers while still using a private IP address

