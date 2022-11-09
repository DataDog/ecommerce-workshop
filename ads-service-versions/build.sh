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
docker image build --platform linux/amd64 --progress=plain --tag ddtraining/ads_versions_v1:latest -f ads_v1/Dockerfile .
docker push ddtraining/ads_versions_v1:latest

# Build and tag image (ads version2)
cp ads_versions/ads_2.py ./ads.py
docker image build --platform linux/amd64 --progress=plain --tag ddtraining/ads_versions_v2:latest -f ads_v2/Dockerfile .
docker push ddtraining/ads_versions_v2:latest

# Build and tag image (ads version2.1)
cp ads_versions/ads_2_1.py ./ads.py
docker image build --platform linux/amd64 --progress=plain --tag ddtraining/ads_versions_v2_1:latest -f ads_v2_1/Dockerfile .
docker push ddtraining/ads_versions_v2_1:latest

