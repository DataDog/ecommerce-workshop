# Automated version release guide

1. Verify that the CHANGELOG.md unreleased section is accurate and up to date by checking the commits between tags
1. Update the CHANGELOG.md unrelease section with the next version number. Use [Semver](https://semver.org/) to determine how far to bump things up.
1. Make a new commit with that changelog using "Release [version]" (e.g. "Release 1.2.3")
1. Make a new tag with the version number `git tag --annotate 1.0.0 --message="Release 1.0.0"`
1. Push the new tag `git push && git push --tags`
1. Monitor the new release workflow in Github Actions which should complete the rest

# Manual version release guide

Note: Replace 1.0.0 with the version number you are releasing

1. Verify that the CHANGELOG.md unreleased section is accurate and up to date by checking the commits between tags
1. Update the CHANGELOG.md unrelease section with the next version number. Use [Semver](https://semver.org/) to determine how far to bump things up.
1. Make a new commit with that changelog using "Release 1.0.0"
1. Make a new tag with the version number `git tag --annotate 1.0.0 --message="Release 1.0.0"`
1. Push the new tag `git push && git push --tags`
1. Go to the [tags page](https://github.com/DataDog/ecommerce-workshop/tags) and click the three dots to the right to "Create release". In the prompt, copy and paste the `CHANGELOG.md` notes for the 1.0.0 release in the body and put "1.0.0" for the title.
1. Pull down the latest advertisements image `docker pull ddtraining/advertisements:latest`
1. Tag the advertisements latest image with the new version number `docker tag ddtraining/advertisements:latest ddtraining/advertisements:1.0.0`
1. Push the advertisements image up `docker push ddtraining/advertisements:1.0.0`
1. Pull down the latest advertisements-fixed image `docker pull ddtraining/advertisements-fixed:latest`
1. Tag the advertisements latest image with the new version number `docker tag ddtraining/advertisements-fixed:latest ddtraining/advertisements-fixed:1.0.0`
1. Push the advertisements-fixed image up `docker push ddtraining/advertisements-fixed:1.0.0`
1. Pull down the latest discounts image `docker pull ddtraining/discounts:latest`
1. Tag the discounts latest image with the new version number `docker tag ddtraining/discounts:latest ddtraining/discounts:1.0.0`
1. Push the discounts image up `docker push ddtraining/discounts:1.0.0`
1. Pull down the latest discounts-fixed image `docker pull ddtraining/discounts-fixed:latest`
1. Tag the discounts-fixed latest image with the new version number `docker tag ddtraining/discounts-fixed:latest ddtraining/discounts-fixed:1.0.0`
1. Push the discounts-fixed image up `docker push ddtraining/discounts-fixed:1.0.0`
1. Pull down the latest storefront image `docker pull ddtraining/storefront:latest`
1. Tag the storefront latest image with the new version number `docker tag ddtraining/storefront:latest ddtraining/storefront:1.0.0`
1. Push the storefront image up `docker push ddtraining/storefront:1.0.0`
1. Pull down the latest storefront-fixed image `docker pull ddtraining/storefront-fixed:latest`
1. Tag the storefront-fixed latest image with the new version number `docker tag ddtraining/storefront-fixed:latest ddtraining/storefront-fixed:1.0.0`
1. Push the storefront-fixed image up `docker push ddtraining/storefront-fixed:1.0.0`
