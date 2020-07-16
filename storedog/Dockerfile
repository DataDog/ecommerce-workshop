# Defaults
ARG RUBY_VERSION=2.7.1
ARG NODE_MAJOR=12
ARG BUNDLER_VERSION=2.1.4
ARG YARN_VERSION=1.22.4

# Common Ruby Image
FROM ruby:${RUBY_VERSION}-slim-buster as common

# These need to be re-defined in each stage to be available
ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG YARN_VERSION

# Common package dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    git \
    gnupg2 \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# App's dependencies
RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
  && echo "deb https://deb.nodesource.com/node_${NODE_MAJOR}.x buster main" | tee /etc/apt/sources.list.d/nodesource.list \
  && echo "deb-src https://deb.nodesource.com/node_${NODE_MAJOR}.x buster main" | tee -a /etc/apt/sources.list.d/nodesource.list \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    nodejs \
    yarn=${YARN_VERSION}-1 \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Bundler
RUN mkdir /app /bundle
ENV LANG=C.UTF-8 \
  BUNDLE_PATH=/bundle \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
ENV BUNDLE_APP_CONFIG=${BUNDLE_PATH} \
  BUNDLE_BIN=${BUNDLE_PATH}/bin
ENV PATH /app/bin:${BUNDLE_BIN}:${PATH}
RUN gem update --system \
    && gem install bundler:${BUNDLER_VERSION}

WORKDIR /app
EXPOSE 3000

# === Development image ===
FROM common as development
ENV RAILS_ENV=development
CMD ["/usr/bin/bash"]

# === Production image ===
FROM common as production
ENV RAILS_ENV=production

# Container user
RUN groupadd dog \
  && useradd --gid dog --shell /bin/bash --create-home dog \
  && chown -R dog:dog /app /bundle

USER dog

COPY --chown=dog:dog Gemfile* .
RUN bundle install --without development test

COPY --chown=dog:dog . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
