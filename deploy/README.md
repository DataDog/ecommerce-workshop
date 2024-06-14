This folder contains the different tested ways in which this application can be deployed:

* `aws`: Deployments to Amazon Web Services
  * `aws/ecs`: Deployment to Amazon ECS
* `datadog`: Deploying datadog via HELM or kubernetes manifests
* `docker-compose`: Docker compose to run the application locally
* `ecommerce`: HELM Chart to deploy ecommerce app easily to k3s/k8s environments
* `gcp`: Deployments to Google Cloud Platform
* `generic-k8s`: Generic Kubernetes manifests
* `gke`: Deployment to Google Kubernetes Engine
* `openshift`: Manifests to deploy the application to Openshift
* `terraform`: Terraform based deployments separated by platform
* `vms`: Deployment to GCP VMs using Terraform

## Running the Application Locally

Look at the `docker-compose` folder README for details.

## Installing Datadog via HELM Chart

### Requirements

* Install [HELM v3](https://helm.sh/docs/intro/install/)
* [Generate a Datadog API Key](https://app.datadoghq.com/account/settings#api)
* Optionally [Generate a Datadog Application Key](https://app.datadoghq.com/account/settings#api) if you are deploying the cluster monitor
* A kubernetes cluster configured with `kubectl`

### Installing

* Make sure you have a working `kubectl`, you may need to switch to the platform folder first (try running `kubectl get pods` as a test)
* Run `helm repo add datadog https://helm.datadoghq.com` to track our official HELM repo
* Run `helm repo update` to sync up the latest chart
* Make your own copy of the `helm-values.yaml.example` in the datadog folder `cp datadog/helm-values.yaml.example datadog/helm-values.yaml` and make any changes you would like or just deploy the defaults
* If you are not installing Cluster Agent, run `helm upgrade datadog-agent --install --set datadog.apiKey=<YOUR DATADOG API KEY> --values datadog/helm-values.yaml`
* If you are installing Cluster Agent, run `helm upgrade datadog-agent datadog/datadog --install --set datadog.apiKey=<YOUR DATADOG API KEY> --set datadog.appKey=<YOUR DATADOG APP KEY> --values datadog/helm-values.yaml`
* For upgrading the chart, you can use either of the commands above, it will work even on new installations because of the `--install` flag

## Installing ecommerce app via HELM Chart

### Requirements

* Install [HELM v3](https://helm.sh/docs/intro/install/)
* A kubernetes cluster configured with `kubectl`
* For enabling RUM you need [a client token and ApplicationID](https://docs.datadoghq.com/real_user_monitoring/browser/#setup)

### Installing

* Make sure you have a working `kubectl`, you may need to switch to the platform folder first (try running `kubectl get pods` as a test)
* Change to the `ecommerce` directory
* There are two ways you can run this command if you want to enable RUM or not by defining the API keys
  * To enable RUM, run `helm upgrade ecommerce . --install --set datadog.ddClientToken=<YOUR DATADOG API KEY> --set datadog.ddClientApplicationId=<YOUR DATADOG APP KEY>`
  * If successful, you should see the various services for ecommerce app in `kubectl get pods` output
