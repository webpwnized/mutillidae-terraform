# Mutillidae Terraform Google Cloud Platform Lab Environment

This project contains reference architectures for Google Cloud Platform (GCP) and Microsoft Azure Cloud. The project also contains scripts to generate a deliberately insecure lab environment. The lab environment can be used for demonstrations and in classwork.

## Dependencies for the Google Cloud lab environment

* An operating system to install the needed software
* This project
* Terrform client software
* The Google Cloud Platform (GPC) *gcloud* client software
* A Google Cloud Platform (GPC) project
* A Google Cloud Platform (GCP) Service Account for Terraform

### The Google Cloud Platform (GPC) *gcloud* client software

[**This video**](https://www.youtube.com/watch?v=04GONi_U6zU) shows [**how to install the gcloud CLI on Ubuntu Linux**](https://www.youtube.com/watch?v=04GONi_U6zU). Otherwise, follow [**the instructions for your distribution**](https://cloud.google.com/sdk/docs/install#linux)

## Installation for the Google Cloud lab environment

[**Installation Instructions**](../../README-INSTALL.md)

## How to deploy the lab

The lab files are located in this project within the ***mutillidae-terraform/lab-environment/gcp*** directory. The directory contains a script that will build the lab environment. Run the following script to build the lab environment.

`./build-gcp-lab-environment.sh`

