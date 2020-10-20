This folder contains the different tested ways in which this application can be deployed:

* `aws`: Deployments to Amazon Web Services
 * `aws/ecs`: Deployment to Amazon ECS
* `gcp`: Deployments to Google Cloud Platform
 * `gke`: Deployment to Google Kubernetes Engine
 * `vms`: Deployment to GCP VMs using Terraform
* `generic-k8s`: Generic Kubernetes manifests
* `openshift`: Manifests to deploy the application to Openshift
* `docker-compose`: Docker compose to run the application locally
* `terraform`: Terraform based deployments separated by platform

### Running the Application Locally

The application itself runs on `docker-compose`. First, install Docker along with docker-compose. Then sign up with a trial [Datadog account](https://www.datadoghq.com/), and grab your API key from the Integrations->API tab.

Each of the scenarios use a different `docker-compose` file in the `deploy/docker-compose` folder. To run any of the scenarios:

```bash
$ git clone https://github.com/DataDog/ecommerce-workshop.git
$ cd ecommerce-workshop/deploy/docker-compose
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=<YOUR_API_KEY> docker-compose -f <docker_compose_with_your_selected_scenario> up
```

With this, the docker images will be pulled, and you'll be able to visit the app.

When you go to the homepage, you'll notice that, although the site takes a while to load, it mostly looks as if it works. Indeed, there are only a few views that are broken. Try navigating around the site to see if you can't discover the broken pieces.