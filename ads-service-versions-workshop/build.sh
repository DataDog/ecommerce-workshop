#!/bin/bash
# Set bash strict mode so we insta-fail on any errors
# -e: Exit immediately if a command has non-zero exit code, i.e. fails somehow.
#      Otherwise bash is like a Python program that just swallows exceptions.
# -u: Exit with error message if code uses an undefined environment variable,
#     instead of silently continuing with an empty string.
# -o pipefail: Like -e, except for piped commands.
set -euo pipefail

# Enable Docker Buildkit
export DOCKER_BUILDKIT=1

# Build and tag image (ads version1)
cp bootstrap_versions/bootstrap_1.py ./bootstrap.py
cp ads_versions/ads_1.py ./ads.py
docker image build --platform linux/amd64 --progress=plain --tag arapulido/ads-service:1.0 .
docker push arapulido/ads-service:1.0

# Build and tag image (ads version2)
cp bootstrap_versions/bootstrap_2.py ./bootstrap.py
cp ads_versions/ads_2.py ./ads.py
docker image build --platform linux/amd64 --progress=plain --tag arapulido/ads-service:2.0 .
docker push arapulido/ads-service:2.0

# Build and tag image (ads version3)
cp bootstrap_versions/bootstrap_3.py ./bootstrap.py
cp ads_versions/ads_3.py ./ads.py
docker image build --platform linux/amd64 --progress=plain --tag arapulido/ads-service:3.0 .
docker push arapulido/ads-service:3.0
