# Terraform Deployment

This area of the repo is dedicated to a terraform based deployment of the ecommerce-workshop application.

## Requirements

* [Terraform 0.13+](https://terraform.io)

## Initial Setup

* Run `terraform init` to install all of the needed terraform modules
* Run `terraform apply` to spin up the cluster. The location of the cluster will output at the end.

## Automatic `kubectl` config

When you `terraform apply` and it is successful, this terraform configuration will automatically write a `kube_config_server.yaml` file to use with `kubectl`. To automatically use that config, you need to export the `KUBECONFIG` environment variable pointing to this file like so:

```bash
export KUBECONFIG="$(pwd)/kube_config_server.yaml"
```

If you use [direnv](https://direnv.net/) you can put the above line into an `.envrc` in this directory to automatically load the config for you each time you visit this directory.