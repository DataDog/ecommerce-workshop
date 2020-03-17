
# eCommerce Observability in Practice 

This is a repo demonstrating applying observability principals to an eCommerce app.

In this hypothetical scenario, we've got a [Spree](https://spreecommerce.org/) website, that a team has started adding microservices to. In it's current state, the application is broken.

![storedog](https://github.com/DataDog/ecommerce-workshop/raw/master/images/storedog.png)

We'll take that broken application, instrument it with Datadog, and then deploy a fix. After deploying a fix, we'll look into Datadog to ensure our deploy worked, and that our systems are actually functioning properly.

## Structure of the repository

This repository is used to build the Docker images to run the application in the different states. The folders that build each of the images are the following:

* `ads-service`- The advertisement microservice. There is only one state of this service.
* `discounts-service`- The discounts microservice. There is only one state of this service.
* `store-frontend-broken-no-instrumentation`- The Spree application in a broken state and with no instrumentation. This is the initial scenario.
* `store-frontend-broken-instrumented`- The Spree application in a broken state but instrumented with Datadog APM. This is the second scenario.
* `store-frontend-instrumented-fixed`- The Spree application instrumented with Datadog APM and fixed. This is the final scenario.

To build any of the images you should `cd` into each of the folders and run:

```
docker build .
```

Feel free to [follow along](https://www.katacoda.com/DataDog/scenarios/ecommerce-workshop) with the scenario, or to run the application locally.

## Running the Application Locally

The application itself runs on `docker-compose`. First, install Docker along with docker-compose. Then sign up with a trial [Datadog account](https://www.datadoghq.com/), and grab your API key from the Integrations->API tab.

Each of the scenarios use a different `docker-compose` file in the `docker-compose-files` folder. To run any of the scenarios:

```bash
$ git clone https://github.com/DataDog/ecommerce-workshop.git
$ cd docker-compose-files
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=<YOUR_API_KEY> docker-compose -f <docker_compose_with_your_selected_scenario> up
```

With this, the docker images will be pulled, and you'll be able to visit the app.

When you go to the homepage, you'll notice that, although the site takes a while to load, it mostly looks as if it works. Indeed, there are only a few views that are broken. Try navigating around the site to see if you can't discover the broken pieces.

## Creating Example Traffic To Your Site

The Katacoda scenario uses `gor` to spin up traffic our own (dysfunctional) stores, and then diagnose and fix them with replayed live traffic.

This way, we don't have to manually click around the site to see all the places where our site is broken.

You can reuse the recorded traffic I've already kept with a:

```bash
$ ./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"
```

This command opens up my traffic recording, and ships all the requests to `localhost`, at port 3000. After running this traffic generator for a while, we'll be able to see the services that make up our application within Datadog.

## Viewing Our Broken Services in Datadog

Once we've spun up our site, and ship traffic with `gor`, we can then view the health of the systems we've deployed. But first, let's see the structure of our services by visiting the Service Map.

![Datadog Service Map](https://github.com/DataDog/ecommerce-workshop/raw/master/images/service-map.png)

Here, we can see we've got a `store-frontend` service, that appears to connect to SQLite as its datastore. Downstream, we've got a `discounts-service`, along with an `advertisements-service`, both of which connect to the same PostgreSQL server.

With this architecture in mind, we can then head over to the Services page, and see where the errors might be coming from. Is it one of the new microservices?

![Datadog Services List](https://github.com/DataDog/ecommerce-workshop/raw/master/images/services-list.png)

Looking at the services list, we can sort by either latency, or errors. Looking at all our services, it appears only the `store-frontend` has errors, with an error rate of ~5%.

By clicking on the `store-frontend`, we can then drill further and see which endpoints are causing trouble. It seems like it's more than one:

![View Trace](https://github.com/DataDog/ecommerce-workshop/raw/master/images/problematic-service.gif)

We _could_ click one level down and view one of the endpoints that's generating a trace. We can also head over to the Traces page, and sort by error traces:

![Trace Errors](https://github.com/DataDog/ecommerce-workshop/raw/master/images/error-traces.gif)

With this, we've got a line number that appears to be generating our errors. Checking across multiple traces, we can see the same behavior. It looks like the new advertisement call was pushed to the wrong file.

## Finding a Bottleneck

Once we've applied the fix for the wrong file, we still see slow behavior. We can drill down into a service and see where the bottleneck is by sorting via latency on the Services Page:

![Bottleneck](https://github.com/DataDog/ecommerce-workshop/raw/master/images/bottleneck.gif)

