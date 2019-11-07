
# Example Instrumented Ecommerce App

This is a repo demonstrating observability in an eCommerce app.

It's split up into a few different branches, to showcase three specific steps:

`no-instrumentation` - A broken, uninstrumented distributed app. Trying to emulate a team moving to microservices, and having a bad deploy.

`instrumented` - A now instrumented, but still broken app. Used to debug and diagnose what is broken within Datadog.

`instrumented-fixed` - An instrumented, fixed application, ready to see the difference in Datadog between a properly functioning app and a bad deployment.

The `master` branch that you are on now is used to build Docker images that are used in the [Katacoda scenario](https://www.katacoda.com/burningion/scenarios/ecommerce-observability).

The Katacoda scenario uses `gor` to spin up traffic our own (dysfunctional) stores, and then diagnose and fix them with replayed live traffic.

