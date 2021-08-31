## Building

### Docker images for the advertisements and discounts

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

### Docker images for the frontend service

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

## Updating the storefront code

If you are developing and modifying the `storefront` code, you will need to recreate the code for the three versions, and recreate the patches after making the changes.

### Recreating the code

```
cd store-frontend/src/
cp -R store-frontend-initial-state store-frontend-broken-instrumented
cd store-frontend-broken-instrumented
patch -t -p1 < ../broken-instrumented.patch
cd ..
cp -R store-frontend-initial-state store-frontend-instrumented-fixed
cd store-frontend-instrumented-fixed
patch -t -p1 < ../instrumented-fixed.patch
cd ..
```

### Modifying the code

If your changes are part of the core of the code and will be applied to all three versions, do the following:

* Develop the changes in the `store-frontend-initial-state` folder
* Commit the changes made in the `store-frontend-initial-state` folder
* [Regenearate the patches](#Generate-the-patches)
* Commit the patches

If your changes only affect `store-frontend-broken-instrumented` and/or `store-frontend-instrumented-fixed`, do the following:

* Develop the changes in the `store-frontend-broken-instrumented` and/or `store-frontend-instrumented-fixed` folder
* [Regenearate the patches](#Generate-the-patches)
* Commit the patches

### Generate the patches

```
cd store-frontend/src/
diff -urN store-frontend-initial-state store-frontend-instrumented-fixed > instrumented-fixed.patch
diff -urN store-frontend-initial-state store-frontend-broken-instrumented > broken-instrumented.patch
```
