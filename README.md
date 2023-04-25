# Create a Local APT Repository on Azure Blob Storage
In this tutorial, we will show you how to create a local APT repository hosted on Azure Blob Storage. This approach provides a scalable and accessible solution for hosting custom APT repositories, allowing you to easily manage your custom packages or mirror existing repositories for faster access. This is for both public storage accounts and private storage accounts using private end points.

## Prerequisites

An Azure account with an active subscription.
The Azure CLI installed on your local machine.
An Ubuntu Linux VM for testing.

## Step 1: Create a new storage account and container
Create a new storage account in the Azure portal, ensuring that the "hierarchical namespace" feature is enabled. Make sure the storage account is publicly accessible for testing purposes (not recommended for production environments). For production environments, you should use Private Endpoints.

## Step 2: Install the Azure CLI on the Ubuntu VM

Install the Azure CLI on your Ubuntu VM by running the following commands:

<pre>
```
bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```
</pre>
## Step 3: Authenticate with your Azure account

Authenticate your Ubuntu VM with your Azure account by running the following command and following the on-screen instructions:

<pre>
```
bash
az login
```
</pre>
### Step 4: Download and Run the Repository Creation Script

To get started, create a new script file called `create_apt_repo.sh` and paste the content of the script provided in the repo file called `create_apt_repo.sh". Update the script with your Azure Storage Account details, such as `ACCOUNT_NAME`, `ACCOUNT_KEY`, and `CONTAINER_NAME`. 

Here's a brief overview of what the script does:

1. Sets variables such as `ACCOUNT_NAME`, `ACCOUNT_KEY`, and `CONTAINER_NAME`, which correspond to your Azure Storage Account details.
2. Installs the necessary tools like `wget` and `apt-utils` if they're not already installed.
3. Creates a temporary directory to store the downloaded files.
4. Downloads the required packages and metadata files from an existing Ubuntu repository using `wget`.
5. Generates the necessary metadata files, such as `Packages.gz` and `Release` files, using `apt-ftparchive` to create a functional APT repository.
6. Uploads the downloaded packages and generated metadata files to the Azure Blob Storage container.

Make the script executable and run it:

<pre>
```
bash
chmod +x create_apt_repo.sh
./create_apt_repo.sh
```
</pre>

By following this step and running the `create_apt_repo.sh` script, you will set up a local APT repository hosted in an Azure Blob Storage container. This repository can then be used as a package source on Ubuntu machines.

## Step 5: Configure the APT repository on client machines

After running the script, you'll have a local APT repository hosted in an Azure Blob Storage container. To use this repository as a package source on an Ubuntu machine, add the repository URL to the /etc/apt/sources.list file:
<pre>
```
bash
echo "deb [trusted=yes] https://<ACCOUNT_NAME>.blob.core.windows.net/<CONTAINER_NAME>/dists/<RELEASE_NAME>/main/binary-amd64/ /" | sudo tee -a /etc/apt/sources.list
```
</pre>

to update the repo run
<pre>
```
bash
sudo apt update
```
</pre>
## Conclusion

In this tutorial, we showed you how to create a local APT repository hosted on Azure Blob Storage. This approach provides a scalable and accessible solution for hosting custom APT repositories. Now you can easily manage your custom packages or mirror existing repositories for faster access.

Please note that the provided script does not include GnuPG signing for the repository. You may need to modify the script or follow additional steps to include GnuPG signing to ensure the integrity and authenticity of your APT repository.

Happy package managing!