# syntax = docker/dockerfile:1.2
# ^ This enables the new BuildKit stable syntax which can be
# run with the DOCKER_BUILDKIT=1 environment variable in your
# docker build command (see build.sh)
FROM ruby:2.7.2-slim-buster

# Update, upgrade, and cleanup debian packages
RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install -y --no-install-recommends curl build-essential git-core libsqlite3-dev libpq-dev && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y nodejs yarn && \
    rm -rf /var/lib/apt/lists/*

# Copy the non-instrumented app and apply the patch
COPY ./src/store-frontend-initial-state /app
COPY ./src/instrumented-fixed.patch ./app
WORKDIR /app
RUN patch -t -p1 < instrumented-fixed.patch
RUN mkdir -p /opt/storedog
COPY ./docker-entrypoint.sh /opt/storedog/docker-entrypoint.sh
RUN chmod +x /opt/storedog/docker-entrypoint.sh

# COPY ./config/database.yml /spree/sandbox/config/database.yml
#COPY ./store-frontend /spree/store-frontend
RUN chgrp -R 0 /app && \
    chmod -R g=u /app

# Copy in our frontend and run bundle
RUN bundle install && \
    yarn install

# Force STDOUT logging
ENV RAILS_LOG_TO_STDOUT=true

CMD ["sh", "/opt/storedog/docker-entrypoint.sh"]
