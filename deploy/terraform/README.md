# Terraform Deployment

This area of the repo is dedicated to a terraform based deployment of the ecommerce-workshop application.

## Requirements

* [Terraform 0.13+](https://terraform.io) (Check your current version with `terraform version`)

## Platform Folders

In order to setup the infrastructure for any of the deployment options, we have created separate provider-based folders for you to use. Just `cd` into the provider of your preference and follow the README for further instructions.

## Adding a new platform

To add another deployment platform you can copy an existing one and name the folder after the platform target. For example, you can `cp -R digitalocean aks` to make an Azure Kubernetes deployment platform target, but you will have to modify all the files to match the Azure Terraform provider resources and provider. Of course, don't forget to update the README with instructions.

One other thing your integration should be doing is making an output that writes the kubectl configuration to the deploy folder. If you need an example, look at `output.tf` in the digitalocean folder.