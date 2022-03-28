
# eCommerce Observability in Practice

This is a repo demonstrating applying observability principals to an eCommerce app.

In this hypothetical scenario, we've got a [Spree](https://spreecommerce.org/) website, that a team has started adding microservices to. In it's current state, the application is broken.

![storedog](https://github.com/DataDog/ecommerce-workshop/raw/master/images/storedog.png)

We'll take that broken application, instrument it with Datadog, and then deploy a fix. After deploying a fix, we'll look into Datadog to ensure our deploy worked, and that our systems are actually functioning properly.

## Structure of the repository

This repository is used to build the Docker images to run the application in the different states. The folders that build each of the images are the following:

* `ads-service`- The advertisement microservice with a couple of injected sleeps.
* `ads-service-fixed`- The advertisement microservice with the sleeps removed.
* `ads-service-errors`- The advertisement microservice that will return 500 errors on the `/ads` endpoint
* `discounts-service`- The discounts microservice with an [N+1 query](#finding-an-n1-query) and a couple of sleeps.
* `discounts-service-fixed`- The discounts microservice with the N+1 query fixed and the sleeps removed.
* `store-frontend-broken-no-instrumentation`- The Spree application in a broken state and with no instrumentation. This is the initial scenario.
* `store-frontend-broken-instrumented`- The Spree application in a broken state but instrumented with Datadog APM. This is the second scenario.
* `store-frontend-instrumented-fixed`- The Spree application instrumented with Datadog APM and fixed. This is the final scenario.
* `traffic-replay`- Looping replay of live traffic to send requests to `frontend` (see [Creating Example Traffic](#creating-example-traffic-to-your-site) for details)

Feel free to [follow along](https://www.katacoda.com/DataDog/scenarios/ecommerce-workshop) with the scenario, or to run the application locally.

## Building the docker images

Follow the [specific guide for building the images](./development.md#Building)

## Deploying the application

The `deploy` folder contains the different tested ways in which this application can be deployed.

## Enabling Real User Monitoring (RUM)

Real User Monitoring is enabled for the `docker-compose-fixed-instrumented.yml` docker compose and the Kubernetes `frontend.yaml` deployment.

To enable it, you'll need to log into Datadog, navigate to RUM Applications, and create a new application.

Once created, you'll get a piece of Javascript with an `applicationId` and a `clientToken`.

Pass these environment variables to docker-compose:

```
$ DD_API_KEY=<YOUR_API_KEY> DD_CLIENT_TOKEN=<CLIENT_TOKEN> DD_APPLICATION_ID=<APPLICATION_ID> POSTGRES_USER=<POSTGRES_USER> POSTGRES_PASSWORD=<POSTGRES_PASSWORD> POSTGRES_HOST="db" docker-compose -f docker-compose-fixed-instrumented.yml up
```

Or uncomment the following lines in the `frontend.yaml` if in Kubernetes, adding your `applicationID` and your `clientToken`:

```
# Enable RUM
# - name: DD_CLIENT_TOKEN
#   value: <your_client_token>
# - name: DD_APPLICATION_ID
#   value: <your_application_id>
```

After the site comes up, you should be able to navigate around, and then see your Real User Monitoring traffic show up.

## Creating Example Traffic To Your Site

The scenario uses [GoReplay](https://github.com/buger/goreplay) to spin up traffic our own (dysfunctional) stores, and then diagnose and fix them with replayed live traffic.

This way, we don't have to manually click around the site to see all the places where our site is broken.

### Containerized replay

#### Building and running manually

Example traffic can be perpetually sent via the `traffic-replay` container. To build and run it via Docker and connect it to your running cluster in docker-compose (by default the docker-compose_default network is created).

```
cd traffic-replay
docker build -t traffic-replay .
docker run -i -t --net=docker-compose_default --rm traffic-replay
```

By default this container will send traffic to the host `http://frontend:3000` but can be customized via environment variables on the command line or in the below example via Docker Compose.  This facilitates the use of load balancers or breaking apart the application.

```yaml
environment:
  - FRONTEND_HOST=loadbalancer.example.com
  - FRONTEND_PORT=80
```

#### Running via Docker Compose

We automatically build new traffic-replay containers on every release and you can spin up the traffic-replay container with your Docker Compose cluster by adding the config as an override via the example below.

```
POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f deploy/docker-compose/docker-compose-broken-instrumented.yml -f deploy/docker-compose/docker-compose-traffic-replay.yml up
```

Any of the other docker compose configurations can work with this traffic container just by adding another `-f  deploy/docker-compose/docker-compose-traffic-replay.yml` to the compose command.

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

There are a couple of sleeps in both the discounts service and the advertisments service.

Removing the lines that contains:

```python
time.sleep(2.5)
```

will fix the performance issue.

The code with the leftover sleeps lives in `discounts-service` and `ads-service`, and the fixed versions live in `discounts-service-fixed` and `ads-service-fixed`.

## Finding an N+1 Query

In the `discounts-service`, there is an N+1 query:

![N+1 Query](https://github.com/DataDog/ecommerce-workshop/raw/master/images/nplus-query.png)

The problem is a lazy lookup on a relational database.

By changing the line:

```python
discounts = Discount.query.all()
```

To the following:

```python
discounts = Discount.query.options(joinedload('*')).all()
```

We eager load the `discount_type` relation on the `discount`, and can grab all information without multiple trips to the database:

![N+1 Solved](https://github.com/DataDog/ecommerce-workshop/raw/master/images/solved-nplus.png)

The N+1 query example lives in `discounts-service/`, and the fixed version lives in `discounts-service-fixed/`.

## How to run synthetics locally

1. Install `@datadog/datadog-ci` via NPM or Yarn globally on your local machine:

```
npm install -g @datadog/datadog-ci
```
```
yarn global add @datadog/datadog-ci
```

2. Obtain the API and APP Key from the DD corpsite account:
3. From the project root, run the following:
`DD_API_KEY="<API_KEY>" DD_APP_KEY="<APP_KEY>" make synthetics-start`


*To add a new test:*
1. Generate a synthetics test via the DD app
2. Grab the public ID of the test (found in the top left of the synthetic page or in the URL) and add it to `storedog.synthetics.json`.

