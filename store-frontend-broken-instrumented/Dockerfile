# This dockerfile is used to build sandbox image for docker clouds. It's not meant to be used in projects
FROM ruby:2.5.1
RUN apt-get update -qq && \
  apt-get install -y build-essential libpq-dev && \
  curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y nodejs
COPY . /spree
WORKDIR /spree
RUN bundle install
RUN bundle update sassc && bundle exec rake store-frontend
# COPY ./config/database.yml /spree/sandbox/config/database.yml
#COPY ./store-frontend /spree/store-frontend
RUN cd store-frontend && bundle update sassc
WORKDIR /spree
RUN chgrp -R 0 /spree && \
    chmod -R g=u /spree
CMD ["sh", "docker-entrypoint.sh"]
