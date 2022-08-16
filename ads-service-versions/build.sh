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
docker image build --progress=plain --tag arapulido/advertisements_v1:latest .
docker push arapulido/advertisements_v1:latest

# Build and tag image (ads version1)
cp bootstrap_versions/bootstrap_2.py ./bootstrap.py
docker image build --progress=plain --tag arapulido/advertisements_v2:latest .
docker push arapulido/advertisements_v2:latest
