# Digital Ocean

This terraform module sets up and configures a k8s cluster as a deployment target for both Datadog and the Ecommerce application.

## Initial Setup

* Export the following environment variable:
    * `TF_VAR_do_token` with your DigitalOcean API Token
* Review the variables in the `variables.tf` file if you want to make any adjustments
* Run `terraform init` to install all of the needed terraform modules
* Run `terraform apply` to spin up the cluster. The location of the cluster will output at the end.

## Automatic `kubectl` config

When you `terraform apply` and it is successful, this terraform configuration will automatically write a `kube_config_server.yaml` file to use with `kubectl`. To automatically use that config, you need to export the `KUBECONFIG` environment variable pointing to this file like so:

```bash
export KUBECONFIG="$(pwd)/kube_config_server.yaml"
```

If you use [direnv](https://direnv.net/) you can put the above line into an `.envrc` in this directory to automatically load the config for you each time you visit this directory. If you can't or don't want to do that, just make sure you export the KUBECONFIG variable like above, or put it in front of the kubectl command so it knows where to find the kubeconfig file.

To verify you have this configured correctly, try the following command:

```bash
$ kubectl get pods
```

You should see output like this:

```bash
No resources found in default namespace.
```

Now that you have a working kubernetes cluster, you can deploy the Datadog HELM Chart or Ecommerce manifests to start monitoring. For those instructions, see the `README.md` in the deploy folder above this one.

## Important Notes

If you want to upgrade k8s versions on Digital Ocean, you will need at least two nodes or one larger node to perform this operation due to resource constraints in the upgrade process.

Once you destroy the cluster, check for any leftover load balancers in your DigitalOcean account. Any time you apply a k8s manifest containing a LoadBalancer service, they spin up an actual DigitalOcean load balancer for you which is unknown to Terraform and won't be cleared off when you destroy the k8s cluster.
