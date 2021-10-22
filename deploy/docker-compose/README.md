# Docker Compose Files for Live Development or Local Deployment

These files allow for different ways of deploying the ecommerce application locally for development.

Specifically, they mount volumes to allow for livereloading on filesystem changes. You can edit files and have their changes be reflected in your application with a page reload.

They currently exist in three different versions:

`docker-compose-broken-no-instrumentation`: A broken example application, with no Datadog instrumentation. Use to demonstrate how to instrument an application with Datadog

`docker-compose-broken-instrumented`: View a broken application and diagnose it with Datadog

`docker-compose-fixed-instrumented`: View a fixed application and compare it to the previously broken deployment.

`docker-compose-traffic-replay`: Simulate traffic to the application.

The application itself runs on `docker-compose`. First, install Docker along with docker-compose. Then sign up with a trial [Datadog account](https://www.datadoghq.com/), and grab your API key from the Integrations->API tab.

To run any of the scenarios, be in the root directory:

```bash
git clone https://github.com/DataDog/ecommerce-workshop.git
cd ecommerce-workshop
cd store-frontend/src/
cp -R store-frontend-initial-state store-frontend-broken-instrumented
cd store-frontend-broken-instrumented
patch -t -p1 < ../broken-instrumented.patch
cd ..
cp -R store-frontend-initial-state store-frontend-instrumented-fixed
cd store-frontend-instrumented-fixed
patch -t -p1 < ../instrumented-fixed.patch
cd ../../..
POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=<YOUR_API_KEY> docker-compose -f deploy/docker-compose/<docker_compose_with_your_selected_scenario> up
```

With this, the docker images will be pulled, and you'll be able to visit the app.

When you go to the homepage, you'll notice that, although the site takes a while to load, it mostly looks as if it works. Indeed, there are only a few views that are broken. Try navigating around the site to see if you can't discover the broken pieces.
