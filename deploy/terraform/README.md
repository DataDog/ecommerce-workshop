# Terraform Deployment

This area of the repo is dedicated to a terraform based deployment of the ecommerce-workshop application.

## Requirements

* [Terraform 0.13+](https://terraform.io) (Check your current version with `terraform version`)

## Platform Folders

In order to setup the infrastructure for any of the deployment options, we have created separate provider-based folders for you to use. Just `cd` into the provider of your preference and follow the README for further instructions.

## Adding a new platform

To add another deployment platform you can copy an existing one and name the folder after the platform target. For example, you can `cp -R digitalocean aks` to make an Azure Kubernetes deployment platform target, but you will have to modify all the files to match the Azure Terraform provider resources and provider. Of course, don't forget to update the README with instructions.

## Installing Datadog or Ecommerce App

### Requirements

* Install [HELM v3](https://helm.sh/docs/intro/install/)
* [Generate a Datadog API Key](https://app.datadoghq.com/account/settings#api)
* Optionally [Generate a Datadog Application Key](https://app.datadoghq.com/account/settings#api) if you are deploying the cluster monitor

### Installing

* Make sure you have a working `kubectl`, you may need to switch to the platform folder first
* Run `helm repo add datadog https://helm.datadoghq.com` to track our official HELM repo
* Run `helm repo update` to sync up the latest chart
* Create a secret for the API Key `export DATADOG_SECRET_API_KEY_NAME=datadog-api-secret && kubectl create secret generic $DATADOG_SECRET_API_KEY_NAME --from-literal api-key="<DATADOG_API_KEY>" --namespace="default"`
* If you want to install the Cluster Agent, then export an APP Key `export DATADOG_SECRET_APP_KEY_NAME=datadog-app-secret && kubectl create secret generic $DATADOG_SECRET_APP_KEY_NAME --from-literal app-key="<DATADOG_APP_KEY>" --namespace="default"`
* Make your own copy of the `helm-values.yaml.example` in the datadog folder `cp datadog/helm-values.yaml.example datadog/helm-values.yaml` and make any changes you would like or just deploy the defaults
* If you are not installing Cluster Agent, run `helm install datadog-agent --set datadog.apiKeyExistingSecret=<YOUR DATADOG API KEY> --values datadog/helm-values.yaml`
* If you are installing Cluster Agent, run `helm install datadog-agent datadog/datadog --set datadog.apiKeyExistingSecret=$DATADOG_SECRET_API_KEY_NAME --set datadog.appKeyExistingSecret=$DATADOG_SECRET_APP_KEY_NAME --values datadog/helm-values.yaml`

If you ever want to change the values in the chart, you can apply them via a HELM upgrade:

`helm upgrade datadog-agent datadog/datadog --set datadog.apiKeyExistingSecret=$DATADOG_SECRET_API_KEY_NAME --set datadog.appKeyExistingSecret=$DATADOG_SECRET_APP_KEY_NAME --values datadog/helm-values.yaml`