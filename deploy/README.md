This folder contains the different tested ways in which this application can be deployed:

* `aws`: Deployments to Amazon Web Services
  * `aws/ecs`: Deployment to Amazon ECS
* `datadog`: Deploying datadog via HELM or kubernetes manifests
* `docker-compose`: Docker compose to run the application locally
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

### Installing

* Make sure you have a working `kubectl`, you may need to switch to the platform folder first
* Run `helm repo add datadog https://helm.datadoghq.com` to track our official HELM repo
* Run `helm repo update` to sync up the latest chart
* Make your own copy of the `helm-values.yaml.example` in the datadog folder `cp datadog/helm-values.yaml.example datadog/helm-values.yaml` and make any changes you would like or just deploy the defaults
* If you are not installing Cluster Agent, run `helm install datadog-agent --set datadog.apiKey=<YOUR DATADOG API KEY> --values datadog/helm-values.yaml`
* If you are installing Cluster Agent, run `helm install datadog-agent datadog/datadog --set datadog.apiKey=<YOUR DATADOG API KEY> --set datadog.appKey=<YOUR DATADOG APP KEY> --values datadog/helm-values.yaml`

If you ever want to change the values in the chart, you can apply them via a HELM upgrade:

`helm upgrade datadog-agent datadog/datadog --set datadog.apiKey=<YOUR DATADOG API KEY> --set datadog.appKey=<YOUR DATADOG APP KEY> --values datadog/helm-values.yaml`
