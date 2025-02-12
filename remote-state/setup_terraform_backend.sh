#!/bin/bash

# Set variables
RESOURCE_GROUP_NAME="terraform-backend-rg"
STORAGE_ACCOUNT_NAME="tfbackend$RANDOM"  # Ensures a unique name
CONTAINER_NAME="tfstate"

# Login to Azure
az login --output none

# Create Resource Group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create Storage Account (with security best practices)
az storage account create --name $STORAGE_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --location eastus \
  --sku Standard_LRS \
  --encryption-services blob \
  --allow-blob-public-access false \
  --min-tls-version TLS1_2 \
  --https-only true

# Get Storage Account Key
STORAGE_ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" --output tsv)

# Create Blob Container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# Print Storage Account Name for Terraform Backend Configuration
echo "Storage Account Name: $STORAGE_ACCOUNT_NAME"
echo "Resource Group: $RESOURCE_GROUP_NAME"
echo "Container Name: $CONTAINER_NAME"
