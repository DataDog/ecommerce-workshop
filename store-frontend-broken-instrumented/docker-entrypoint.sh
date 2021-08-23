#!/bin/bash
# This is entrypoint for docker image of spree sandbox on docker cloud

# Set our environment to development for now
# TODO: Make this more configurable with a default
export RAILS_ENV=development
# Silence all Ruby 3.0 deprecation warnings for now until we upgrade
# TODO: Remove this once we upgrade to Ruby 3.0 and Rails 6.1
export RUBYOPT='-W0'
# Force semantic-logger to report itself as the storefront app
export SEMANTIC_LOGGER_APP='store-frontend'

puma --config config/puma.rb
