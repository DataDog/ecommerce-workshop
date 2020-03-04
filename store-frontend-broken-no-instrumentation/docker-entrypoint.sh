#!/bin/bash
# This is entrypoint for docker image of spree sandbox on docker cloud

RAILS_ENV=production cd store-frontend && bundle exec rails s -p 3000 -b '0.0.0.0'
