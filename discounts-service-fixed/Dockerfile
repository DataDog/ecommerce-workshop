# syntax = docker/dockerfile:1.2
# ^ This enables the new BuildKit stable syntax which can be
# run with the DOCKER_BUILDKIT=1 environment variable in your
# docker build command (see build.sh)
FROM python:3.9.6-slim-buster

# Update, upgrade, and cleanup debian packages
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes build-essential libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Bring in app
WORKDIR /app
COPY . .

# Install dependencies via pip and avoid caching build artifacts
RUN pip install --no-cache-dir -r requirements.txt

# Let Flask know what to boot
ENV FLASK_APP=discounts.py

# Pass in Port mapping (default to 8282)
ARG DISCOUNTS_PORT=8282
# Because CMD is a runtime instruction, we have to create an additional ENV var that reads the ARG val
# Only ENV vars are accessible via CMD
ENV DISCOUNTS_PORT ${DISCOUNTS_PORT}


# Start the app using ddtrace so we have profiling and tracing
ENTRYPOINT ["ddtrace-run"]
CMD flask run --port=${DISCOUNTS_PORT} --host=0.0.0.0
