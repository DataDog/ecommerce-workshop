## Building

### Building all the containers to test a pull request or develop locally

To build all containers for a local test run:

```
make build
```

This will refresh the local build of every container in the project.

### Docker images for the advertisements and discounts (Manual individial)

There are several versions of the advertisements and discounts services:

* `ads-service`- The advertisement microservice with a couple of injected sleeps.
* `ads-service-fixed`- The advertisement microservice with the sleeps removed.
* `ads-service-errors`- The advertisement microservice that will return 500 errors on the `/ads` endpoint
* `discounts-service`- The discounts microservice with an N+1 query and a couple of sleeps.
* `discounts-service-fixed`- The discounts microservice with the N+1 query fixed and the sleeps removed.

To build any of the images you should `cd` into each of the folders and run:

```
docker build .
```

### Docker images for the frontend service (Manual individial)

There are three versions of the frontend service:

* `store-frontend-broken-no-instrumentation`- The Spree application in a broken state and with no instrumentation. This is the initial scenario.
* `store-frontend-broken-instrumented`- The Spree application in a broken state but instrumented with Datadog APM. This is the second scenario.
* `store-frontend-instrumented-fixed`- The Spree application instrumented with Datadog APM and fixed. This is the final scenario.

The folder structure for those is the following:

```
.
└── store-frontend
    ├── src
    │   ├── store-frontend-initial-state
    │   ├── instrumented-fixed.patch
    │   └── broken-instrumented
    └── storefront-versions
        ├── store-frontend-broken-no-instrumentation
        │   └── Dockerfile
        ├── store-frontend-broken-instrumented
        │   └── Dockerfile
        └── store-frontend-instrumented-fixed
            └── Dockerfile
```

Most of the code is in `store-frontend-initial-state`, corresponding with the `store-frontend-broken-no-instrumentation`, and the other two are built based on that one patching the differences between the intial state and the other two versions (patching is done as part of the Docker build).

To build any of those three versions:

```
cd store-frontend
docker build -f storefront-versions/<VERSION_TO_BUILD>/Dockerfile .
```


### Recreating the code

```
make recreate-frontend-code
```

### Generate the patches

```
make create-frontend-diffs
```


### Modifying the store-frontend code

If your changes are part of the core of the code and will be applied to all three versions, do the following:

* Develop the changes in the `store-frontend-initial-state` folder
* Commit the changes made in the `store-frontend-initial-state` folder

If your changes only affect `store-frontend-broken-instrumented` and/or `store-frontend-instrumented-fixed`, do the following:

* Develop the changes in the `store-frontend-broken-instrumented` and/or `store-frontend-instrumented-fixed` folder
* [Regenerate the patches](#Generate-the-patches)
* Commit the patches

## Testing

In order to test a pull request for a specific scenario you'll need to do the following.

1. Clean up any old containers from your system.
2. Clean any persistent Docker volumes from prior tests of the project.
3. Build the containers for the project.
4. Rebuild the frontend code to ensure all frontend volume mounts will exist
5. Boot the project using `docker-compose`. The suggested compose file to use is `docker-compose-local-baseline`. Run the following command to start the project:
`POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=[Your API key] make local-baseline-start`

> Makefile targets have been provided to speed along testing