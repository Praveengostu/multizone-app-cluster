# multizone-app-cluster

A Terraform configuration for deploying a app on multi zone cluster

This configuration template is tested for IBM Cloud Provider version v0.11.2
# Usage with Terraform Binary on your local workstation
You will need to [setup up IBM Cloud provider credentials](#setting-up-provider-credentials) on your local machine. 


# Prerequisite 
1) Download [Terraform binary](https://www.terraform.io/downloads.html).  Unzip it and keep the binary in path ex- /usr/local/bin.
2) Download [IBM Cloud Provider Plugin](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases). Unzip it and keep the binary in path in the same directory where you placed Terraform binary in previous step. You can also build the binary yourself. Please look into [documentation](https://github.com/IBM-Bluemix/terraform-provider-ibm/blob/master/README.md).

# To run this project locally execute the following steps:

- You can override default values that are in your variables.tf file.
  - Alternatively these values can be supplied via the command line or environment variables, see https://www.terraform.io/intro/getting-started/variables.html.
  - `terraform plan`: this will perform a dry run to show what infrastructure terraform intends to create
- `terraform apply`: this will create actual infrastructure
- `terraform destroy`: this will destroy all infrastructure which has been created

# Setting up Provider Credentials
To setup the IBM Cloud provider to work with this example there are a few options for managing credentials safely; here we'll cover the preferred method using environment variables. Other methods can be used, please see the [Terraform Getting Started Variable documentation](https://www.terraform.io/intro/getting-started/variables.html) for further details.

## Environment Variables using IBMid credentials
You'll need to export the following environment variables:

- `TF_VAR_bluemix_api_key` - your Bluemix api key
- `TF_VAR_private_vlan_id` - provide private vlan id
- `TF_VAR_public_vlan_id` - provide public vlan id



On OS X this is achieved by entering the following into your terminal, replacing the `<value>` characters with the actual values (remove the `<>`:

- `export TF_VAR_bluemix_api_key=<value>`
- `export TF_VAR_private_vlan_id=<value>`
- `export TF_VAR_public_vlan_id=<value>`


# Variables

|Variable Name|Description|Default Value|
|-------------|-----------|-------------|
|region   |           |eu-de|
|datacenter||ams03|
|machine_type||u2c.2x4|
|isolation||public|
|private_vlan_id|||
|public_vlan_id|||

# Output

Upon completion, terraform will output the url of the application, e.g.:

```
app_url_1 = "<url>"

app_url_2 = "<url>"

```
**Use this url to access your application**
