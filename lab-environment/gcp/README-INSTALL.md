# Installation Instructions for the Google Cloud Lab Environment

## Step 1: Set up the Operating System and VirtualBox  
+ ##### If VirtualBox is not installed, [**Install VirtualBox**](https://www.youtube.com/watch?v=61GhP8DsQMw) from the  [**Official Website.**](https://www.virtualbox.org/wiki/Downloads)  
+ ##### If you prefer to use an [**Ubuntu virtual machine**](https://ubuntu.com/download/desktop), [**install Ubuntu on VirtualBox**](https://www.youtube.com/watch?v=Cazzls2sZVk) or any other hypervisor.  
+ ##### For improved performance on VirtualBox, install Guest Additions for Ubuntu as shown in the video. 

## Step 2: Install Required Packages  

+ ##### Open the terminal in the Ubuntu virtual machine by pressing **`Ctrl+Alt+T`**.  
+ ##### Install the necessary packages by running the following commands in the terminal:  
  -   **`sudo apt-get update`**  
  -   **`sudo apt-get install curl`**  
  -   **`sudo apt-get install git`**  
  
## Step 3: Download Terraform Client Software  
 
+ ##### This [**Video**](https://www.youtube.com/watch?v=LM3RLgNu7tU) shows how to install Terraform on Ubuntu Linux. Visit the [**HashiCorp "Install Terraform" Developer Documentation**](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) for the commands to download and install Terraform on your operating system.

## Step 4: Download the Google Cloud (GPC) gcloud Client Software  

+ ##### You can follow the [**video tutorial**](https://www.youtube.com/watch?v=04GONi_U6zU) that demonstrates the step-by-step process of installing the gcloud CLI on Ubuntu Linux. Visit the [**Install the gcloud CLI instruction**](https://cloud.google.com/sdk/docs/install#deb) for the commands.

## Step 5: Prepare SSH Key Pair  

+ ##### Open the terminal and navigate to your home directory using the command **`cd`**.
+ ##### Generate an SSH key pair by following the [**video**](https://www.youtube.com/watch?v=eUwOlc9HfZs) on creating SSH key pairs. Take note of the path where the public key is saved, which should be displayed as: **`"Your public key has been saved in /home/user/.ssh/file_name.pub"`**. Save the path as the **`variable "ssh-public-key-file"`** for later use.

## Step 6: Create a Google Cloud Platform (GPC) Project.  
+ #####	Follow this [video](https://www.youtube.com/watch?v=qUgfKkeJ29Y) tutorial on how to create a project in [Google Cloud Platform](https://console.cloud.google.com/) (GPC). Once you create the project, make note of the project ID, which can be found by clicking on **`"My Project"`** and locating the **`name`** and **`ID`**. Save the project ID as a **`variable "project"`** for future configuration.
+ #####	Additionally, note down your email that you used to create the project. Save your email as a **`variable called "os-login-email-account"`**.

## Step 7: Create Google Cloud (GPC) Service Account for Terraform  
+ ##### Follow the [video](https://www.youtube.com/watch?v=hMcVrKgX30w) on creating a Service Account for Terraform in Google Cloud Platform (GPC).  
+ ##### In addition to the editor role, grant the Service Account the following two roles:  
    - **`Secret Manager Secret Accessor`**  
    - **`Service Networking Admin`** 
+ ##### Click **`"ADD ANOTHER ROLE"`** and search for each role to add it.  
+ ##### Save the path to the Service Account key file, which should be something like **`"/home/user_name/folder_name/gcp-terraform-service-account-key.json"`** . Store this path as the **`variable "terraform-credentials-file"`** for later use.  

## Step 8: Gather Additional Information
+ ##### In the terminal, type **`whoami`** and press enter. Save the displayed username as the **`variable "ssh-username"`**.
+ #####	Browse to **`google.com`** from your virtual machine and search **`"What's my IP"`**. Save the displayed IP address as the **`variable "admin-office-ip-address-range"`**.
+ #####	Save **`your name`** (all lowercase) as the **`variable "default-labels"`**.

## Step 9: Configuration

+ #####	If you are not in the home directory, navigate there using the command **`cd`**.
+ #####	Create a folder named **`"projects"`** using the command **`mkdir projects`**, then navigate to the folder with **`cd projects`**.
+ #####	Clone the project using the command **`git clone https://github.com/webpwnized/mutillidae-terraform.git`**.
+ #####	Change into the lab directory by running the command **`cd mutillidae-terraform/lab-environment/gcp`**.
+ #####	The variables used by Terraform are stored in the file **`variables.tf.CHANGEME`**. Create a new file named **`variables.tf`** and copy the content from **`variables.tf.CHANGEME`** using the command **`cp ../../reference-architecture/gcp/variables.tf.CHANGEME variables.tf`**
+ #####	Open the **`variables.tf`** file using your preferred text editor **`(e.g., nano, vi, vim)`**.
+ #####	Configure the variables in the variables.tf file as follows:
    -	##### For the **`variable “terraform-credentials-file”`**, set the path to the service account key file you saved earlier as the **`default`** value.
    -	##### For the **`variable “project”`**, set the **`project ID`** as the **`default`** value you saved earlier.
    -	##### If Terraform is authenticating with your Gmail account, uncomment the **`os-login.tf`** section and set your **`email address`** as the **`default`** value. Otherwise, leave it as it is.
    -	##### For the **`variable “ssh-username”`**, set your Linux username (found using whoami) as the **`default`** value.
    -	##### For the **`variable “ssh-public-key-file”`**, set the file name you saved earlier as the **`default`** value.
    -	##### For the **`variable “default-labels”`**, set your name (all lowercase) as the **`default`** value.
    -	##### For the **`variable “admin-office-ip-address-range”`**, set your IP address as the **`default`** value.
+ #####	Save the changes made to the variables.tf file.

## Step 10: Enable Required APIs in Google Cloud Platform (GPC)  

+ ##### Verify if the following Google Cloud Platform (GPC) APIs are enabled for your project. If not, enable them by searching each name in the search bar, selecting the corresponding result under **`"MARKETPLACE,"`** and clicking **`"Enable"`**:
    -	**`Compute Engine API`**
    -	**`Cloud Resource Manager API`**
    -	**`Service Networking API`**
    -	**`Cloud SQL Admin API`**
    -	**`Identity and Access Management (IAM) API`**

## Step 11: Deploy the Lab Environment

+ #####	Make sure you are in the lab directory
    -	**`pwd`**
+ #####	In the terminal, navigate to the lab directory if you are not already there by running the command:
    -	**`cd mutillidae-terraform/lab-environment/gcp`**
+ ####	Ensure the Build script is executable:
    -	**`chmod u+x ./build-gcp-lab-environment.sh`**
+ ####	Ensure the Destroy script is executable:
    -	**`chmod u+x ./destroy-gcp-lab-environment.sh`**
+ ####	Run the following script to build the lab environment:
    -	**`./build-gcp-lab-environment.sh`**
+ ####	When you are done, do NOT forget to destroy the lab environment:
    -	**`./destroy-gcp-lab-environment.sh`**

### Congratulations! You have successfully deployed the Lab Environment
