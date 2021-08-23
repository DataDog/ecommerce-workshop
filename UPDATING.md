# Maintenance and Upgrade Guide

## Rails Apps

To upgrade any new gems in the Gemfile do the following procedure. To install new gems, replace the `bundle upgrade` with `bundle install`

### For the broken and instrumented storefront

```
cd store-frontend-broken-instrumented
docker run --interactive --tty --rm --name storefrontdev --mount type=bind,source="$(pwd)",target=/app ddtraining/storefront:latest /bin/bash
# bundle upgrade
# exit
```

Commit the new Gemfile and Gemfile.lock

### For the fixed and instrumented storefront

```
cd store-frontend-instrumented-fixed
docker run --interactive --tty --rm --name storefrontdev --mount type=bind,source="$(pwd)",target=/app ddtraining/storefront-fixed:latest /bin/bash
# bundle upgrade
# exit
```

Commit the new Gemfile and Gemfile.lock
