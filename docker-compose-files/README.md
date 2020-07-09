# Docker Compose Files for Live Development  

These files allow for different ways of deploying the ecommerce application locally for development.

Specifically, they mount volumes to allow for livereloading on filesystem changes. You can edit files and have their changes be reflected in your application with a page reload.

They currently exist in three different versions:

`docker-compose-broken-no-instrumentation`: A broken example application, with no Datadog instrumentation. Use to demonstrate how to instrument an application with Datadog

`docker-compose-broken-instrumented`: View a broken application and diagnose it with Datadog

`docker-compose-fixed-instrumented`: View a fixed application and compare it to the previously broken deployment.
