# Hosting Your Own Ubuntu APT Repository in Azure Blob Storage

## Logical Archietcure

## Introduction

Managing software packages in a controlled and efficient manner is crucial for any Linux system administrator. In Ubuntu, the Advanced Package Tool (APT) is widely used for package management. However, sometimes you may want to create your own APT repository to manage your custom packages or mirror an existing repository for faster access.

In this tutorial, we'll guide you through creating a local APT repository hosted on Azure Blob Storage. This approach can be useful if you want a scalable, accessible, and cost-effective solution for hosting your custom APT repositories.

## Prerequisites

Before we start, ensure you have the following:

1. An Azure subscription.
2. Azure CLI installed on your local machine.
3. An Ubuntu Linux machine (physical, virtual, or cloud-based).

## Step 1: Create a new storage account with hierarchical namespace

Log in to the Azure Portal and create a new storage account. Make sure to enable the hierarchical namespace feature and set the storage account's access level to "public" for testing purposes (not recommended for production environments).

## Step 2: Deploy an Ubuntu Linux VM

Deploy an Ubuntu Linux VM in Azure. You can use the Azure Portal, Azure CLI, or any other tool you prefer. This VM will be used to download packages and metadata from an existing Ubuntu repository and upload them to your Azure Blob Storage container.

## Step 3: Install the required tools

On your Ubuntu VM, install the wget and apt-utils packages. These tools are necessary for downloading packages and creating the necessary metadata files.

```bash
sudo apt update
sudo apt install wget apt-utils -y

## Step 4: Download and run the repository creation script
Create a new script file called create_apt_repo.sh and paste the content of the script provided in this post. Update the script with your Azure Storage Account details, such as ACCOUNT_NAME, ACCOUNT_KEY, and CONTAINER_NAME. Then, make the script executable and run it:

```bash

chmod +x create_apt_repo.sh
./create_apt_repo.sh

## Step 5: Configure the APT repository on client machines
After running the script, you'll have a local APT repository hosted in an Azure Blob Storage container. To use this repository as a package source on an Ubuntu machine, add the repository URL to the /etc/apt/sources.list file:

```bash

echo "deb [trusted=yes] https://<ACCOUNT_NAME>.blob.core.windows.net/<CONTAINER_NAME>/dists/<RELEASE_NAME>/main/binary-amd64/ /" | sudo tee -a /etc/apt/sources.list

## Conclusion
In this tutorial, we showed you how to create a local APT repository hosted on Azure Blob Storage. This approach provides a scalable and accessible solution for hosting custom APT repositories. Now you can easily manage your custom packages or mirror existing repositories for faster access.

Please note that the provided script does not include GnuPG signing for the repository. You may need to modify the script or follow additional steps to include GnuPG signing to ensure the integrity and authenticity of your APT repository.

Happy package managing!