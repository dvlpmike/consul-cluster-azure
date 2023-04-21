# Terraform Consul Cluster on Azure

## Prerequisites
Run below commands on Azure:
```sh
# Create resource group
az group create -n terraform-consul-azure -l westeurope

# Crete storage account
az storage account create -n tcasa -g terraform-consul-azure -l westeurope --sku Standard_LRS

# Create container
az storage container create --account-name tcasa -n tcatfstate

# Create Service Principal 
az ad sp create-for-rbac --name tcasp

# Add role for app
az role assignment create --assignee <service-principal-id> --role "Contributor"
```
Add secretes do repo:
- `AZURE_CLIENT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_TENANT_ID`
- `AZURE_AD_CLIENT_SECRET`
