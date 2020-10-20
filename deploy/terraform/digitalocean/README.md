# Digital Ocean

This terraform module sets up and configures a k8s cluster as a deployment target for both Datadog and the Ecommerce application.

## Initial Setup

* Export the following environment variables:
    * `TF_VAR_do_token` with your DigitalOcean API Token
    * `TF_VAR_dd_api_key` with your Datadog API Key
    * `TF_VAR_dd_app_key` with your Datadog Application Key
* Run `terraform init` to install all of the needed terraform modules
* Run `terraform apply` to spin up the cluster. The location of the cluster will output at the end.

## Automatic `kubectl` config

When you `terraform apply` and it is successful, this terraform configuration will automatically write a `kube_config_server.yaml` file to use with `kubectl`. To automatically use that config, you need to export the `KUBECONFIG` environment variable pointing to this file like so:

```bash
export KUBECONFIG="$(pwd)/kube_config_server.yaml"
```

If you use [direnv](https://direnv.net/) you can put the above line into an `.envrc` in this directory to automatically load the config for you each time you visit this directory.