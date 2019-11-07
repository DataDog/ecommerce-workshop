
# eCommerce Observability in Practice 

This is a repo demonstrating applying observability principals to an eCommerce app.

In this hypothetical scenario, we've got a [Spree](https://spreecommerce.org/) website, that a team has started adding microservices to. In it's current state, the application is broken.

We'll take that broken application, instrument it with Datadog, and then deploy a fix. After deploying a fix, we'll look into Datadog to ensure our deploy worked, and that our systems are actually functioning properly.

## Structure of the Application

The `master` branch that you are on now is used to build Docker images that are used in the [Katacoda scenario](https://www.katacoda.com/burningion/scenarios/ecommerce-observability). None of the example pieces of the app live within this branch.

The application itself is split up into a few different branches, to showcase three specific steps:

`no-instrumentation` - A broken, uninstrumented distributed app. Trying to emulate a team moving to microservices, and having a bad deploy.

`instrumented` - A now instrumented, but still broken app. Used to debug and diagnose what is broken within Datadog.

`instrumented-fixed` - An instrumented, fixed application, ready to see the difference in Datadog between a properly functioning app and a bad deployment.

Feel free to [follow along](https://www.katacoda.com/burningion/scenarios/ecommerce-observability) with the scenario, or to use the raw markdown as your guide.

## Running the Application Locally

The application itself runs on `docker-compose`. Install Docker along with docker-compose. Then create a trial Datadog account, and grab your API key from the Integrations->API tab. Finally:

```bash
$ git clone https://github.com/burningion/ecommerce-observability/
$ git checkout instrumented
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=<YOUR_API_KEY> docker-compose up
```

With this, the docker images will be pulled, and you'll be able to visit the (broken), instrumented app.

## Creating Example Traffic To Your Site

The Katacoda scenario uses `gor` to spin up traffic our own (dysfunctional) stores, and then diagnose and fix them with replayed live traffic.

You can reuse the recorded traffic I've already kept with a:

```bash
$ ./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"
```

This assumes our application is running locally on port 3000.

## Viewing Our Broken Services