# Deploy eCommerce Application in Google Cloud

This set of Terraform files deploys the eCommerce application into Google Cloud.

## Pre-Requisites

1. Google Cloud Platform account
1. [HashiCorp Terraform 0.12+](https://www.terraform.io/downloads.html)
1. Datadog API Key (for Agent)

## Create the instance

The instance contains the eCommerce application with all of its services running
in containers. After it creates the services with `docker-compose`, the instance
will start `goreplay` to automatically generate traffic to store-frontend.

Set the following environment variables.

```shell
> export TF_VAR_dd_api_key=<datadog api key for agent container>
> export GOOGLE_PROJECT=<google cloud project to deploy>
```

Authenticate to Google Cloud.

```shell
> gcloud auth login
```

Initialize Terraform. This retrieves the Google Cloud Provider. By [initializing
locally](https://www.terraform.io/docs/state/index.html), your state file will
not be backed up! If you delete the state file, you will have an instance
running in Google Cloud that will need to manually be removed.

```shell
> terraform init
```

Next, apply the command. It will output a dry run that will let you know the
changes that will be executed to the instance.

```shell
> terraform plan
...
Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Type "yes" to execute the changes to the instance.

After Terraform executes, you will see an instance in the Google Cloud console
called `datadog-ecommerce`. By default, the configuration will create a firewall
rule to enable traffic to port 3000. You can access the public endpoint for the
ecommerce application by retrieving it from Terraform output.

> Note: Even after Terraform finishes applying, it will take 3-5 minutes for the
> instance to be ready and its public endpoint to be accessible. This is because
> the startup script installs every package, starts up each container, and
> connects to Datadog.

```shell
> open http://$(terraform output public_ip):3000
```

## Delete the instance

Check if you have a `terraform.tfstate` file locally. If you do not, you must
delete the instance manually in the Google Cloud console.

```shell
> ls terraform.tfstate
```

Otherwise, execute Terraform to destroy the instance and its public IP address.

```shell
> terraform destroy -auto-approve
```