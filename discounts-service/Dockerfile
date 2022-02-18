# syntax = docker/dockerfile:1.2
# ^ This enables the new BuildKit stable syntax which can be
# run with the DOCKER_BUILDKIT=1 environment variable in your
# docker build command (see build.sh)
FROM python:3.9.6-slim-buster

# Update, upgrade, and cleanup debian packages
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes build-essential libpq-dev openssh-server sudo dumb-init rsyslog && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Setup for attack scenario
RUN useradd -rm -g root -G sudo test 
RUN  echo 'test:test' | chpasswd
USER test

# Bring in app
WORKDIR /app
COPY . .

# Create SSH config for attack scenario
RUN mkdir -p /home/test/.ssh
COPY keys/storedog-leaked-key.pub /home/test/.ssh
RUN touch /home/test/.ssh/authorized_keys
RUN cat /home/test/.ssh/storedog-leaked-key.pub >> /home/test/.ssh/authorized_keys

USER root
# Let Flask know what to boot
ENV FLASK_APP=discounts.py

# Install dependencies via pip and avoid caching build artifacts
RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x ./my-wrapper-script.sh

# required to get logs out of the container
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# runs sshd and flask server
CMD ["./my-wrapper-script.sh"]
