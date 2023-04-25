# Create a Local APT Repository on Azure Blob Storage
In this tutorial, we will show you how to create a local APT repository hosted on Azure Blob Storage. This approach provides a scalable and accessible solution for hosting custom APT repositories, allowing you to easily manage your custom packages or mirror existing repositories for faster access. This is for both public storage accounts and private storage accounts using private end points.

## Prerequisites

An Azure account with an active subscription.
The Azure CLI installed on your local machine.
An Ubuntu Linux VM for testing.
Step 1: Create a new storage account and container
Create a new storage account in the Azure portal, ensuring that the "hierarchical namespace" feature is enabled. Make sure the storage account is publicly accessible for testing purposes (not recommended for development or production environments). For production environments, you should use Private Endpoints.

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
## Step 4: Download and run the repository creation script

Create a new script file called create_apt_repo.sh and paste the content of the script provided in this post. Update the script with your Azure Storage Account details, such as ACCOUNT_NAME, ACCOUNT_KEY, and CONTAINER_NAME. Then, make the script executable and run it:

<pre>
```
bash
chmod +x create_apt_repo.sh
./create_apt_repo.sh
```
</pre>
## Step 5: Configure the APT repository on client machines

After running the script, you'll have a local APT repository hosted in an Azure Blob Storage container. To use this repository as a package source on an Ubuntu machine, add the repository URL to the /etc/apt/sources.list file:
<pre>
```
bash
echo "deb [trusted=yes] https://<ACCOUNT_NAME>.blob.core.windows.net/<CONTAINER_NAME>/dists/<RELEASE_NAME>/main/binary-amd64/ /" | sudo tee -a /etc/apt/sources.list
```
</pre>
## Conclusion

In this tutorial, we showed you how to create a local APT repository hosted on Azure Blob Storage. This approach provides a scalable and accessible solution for hosting custom APT repositories. Now you can easily manage your custom packages or mirror existing repositories for faster access.

Please note that the provided script does not include GnuPG signing for the repository. You may need to modify the script or follow additional steps to include GnuPG signing to ensure the integrity and authenticity of your APT repository.

Happy package managing!