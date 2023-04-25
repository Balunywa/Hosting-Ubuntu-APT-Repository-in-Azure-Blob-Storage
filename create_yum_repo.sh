#!/bin/bash

# Update package lists
sudo yum -y update

# Install wget
sudo yum -y install wget

# Install Azure CLI if not installed
if ! command -v az &> /dev/null; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
  sudo yum -y install azure-cli
fi

# Variables
MIRROR_URL="https://<MIRROR_URL>/centos"
STORAGE_ACCOUNT="<STORAGE_ACCOUNT>"
CONTAINER_NAME="<CONTAINER_NAME>"
ACCOUNT_KEY="<STORAGE_ACCOUNT_KEY>"

# Create directories
mkdir -p repos/{base,extras,updates}

# Download repository metadata files
echo "Downloading repository metadata files..."
wget -q -P repos/base/ ${MIRROR_URL}/7/os/x86_64/repodata/repomd.xml
wget -q -P repos/extras/ ${MIRROR_URL}/7/extras/x86_64/repodata/repomd.xml
wget -q -P repos/updates/ ${MIRROR_URL}/7/updates/x86_64/repodata/repomd.xml

# Check if repos directory exists
if [ ! -d "repos" ]; then
  echo "Error: 'repos' directory not found. Please ensure the wget commands are downloading the files correctly."
  exit 1
fi

# Upload repos directory to Azure Blob Storage
echo "Uploading repos directory to Azure Blob Storage..."
az storage blob upload-batch -s repos -d ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT} --account-key ${ACCOUNT_KEY} --destination-path repos

echo "YUM repository metadata successfully downloaded and uploaded to Azure Blob Storage."
