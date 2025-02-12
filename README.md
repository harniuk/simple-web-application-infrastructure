# Simple Web Application Infrastructure

This guide outlines the steps to deploy a web application on Microsoft Azure using GitHub Actions for CI/CD, Terraform for infrastructure provisioning, and Ansible for configuration management.

## Prerequisites

Azure CLI: For interacting with Azure services.

## Step 1: Set Up Azure Service Principal

Create a service principal with the necessary permissions to manage Azure resources:

> az ad sp create-for-rbac --name "sample-app" --role="Contributor" --scopes /subscriptions/<SUBSCRIPTION_ID> --sdk-auth

Copy the output JSON and extract the following values:

clientId → ***AZURE_CLIENT_ID***

clientSecret → ***AZURE_CLIENT_SECRET***

subscriptionId → ***AZURE_SUBSCRIPTION_ID***

tenantId → ***AZURE_TENANT_ID***

## Step 2: Store Secrets in GitHub Actions

Follow [GitHub's guide](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-a-repository)  to create repository secrets with the extracted values:

***AZURE_CLIENT_ID***

***AZURE_TENANT_ID***

***AZURE_SUBSCRIPTION_ID***

***AZURE_CLIENT_SECRET***

## Step 3: Generate SSH Key Pair

Generate an SSH key pair to securely access the deployed infrastructure:

> ssh-keygen -t rsa -b 4096 -C "name"

Add the generated keys as GitHub secrets:

***SSH_PRIVATE_KEY*** → Private key (id_rsa)

***TF_VAR_SSH_PUBLIC_KEY*** → Public key (id_rsa.pub)

## Step 4: Specify the approvers

Only specified approvers can accept changes
Add the approver username as a ***GitHub variable***:

***APPROVERS***

## Step 5: Create Database Password

Ensure your database password meets security standards (minimum 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character). Add this as a GitHub secret:

***DB_PASSWORD***

## Step 6: Configure Terraform Remote State

Set up a remote backend for Terraform state storage. You can use the provided script:

> bash remote-state/setup_terraform_backend.sh

Ensure the backend configuration is correctly set in terraform/main.tf.

## Step 7: Define Flask Repository (If Required)

If using a Flask application, specify the repository path in:

> ansible/roles/flask_app/vars/main.yml

## Step 8: Deploy Infrastructure

Push the code to the main branch to trigger the GitHub Actions workflow, which will:

Authenticate with Azure.

Provision infrastructure using Terraform.

Configure the application using Ansible.

Deploy the Flask application (if applicable).

Your web application should now be deployed on Azure. Monitor the GitHub Actions logs for any issues during the deployment process.


# Architecture diagram

![Architecture diagram](https://github.com/harniuk/simple-web-application-infrastructure/blob/main/architecture_diagram.svg)


## Security considerations

All sensitive data, such as keys and passwords are securely stored in GitHub Secrets.

The Terraform state is stored in Azure Storage with Role-Based Access Control (RBAC) to restrict access.
Encryption is enabled to protect sensitive infrastructure configurations.

Ports are temporarily opened for external access only during testing.
This approach is not recommended for production environments.

Changes to the infrastructure require approval from designated approvers before being applied.