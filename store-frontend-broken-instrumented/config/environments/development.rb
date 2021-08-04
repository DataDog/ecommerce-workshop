Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Silence the web console warnings
  config.web_console.whiny_requests = false

  # Enable lograge and format in JSON for easier parsing
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.colorize_logging = false
  config.log_level = :info
  config.action_controller.enable_fragment_cache_logging = false
  # This is useful if you want to log query parameters
  config.lograge.custom_options = lambda do |event|
    # Retrieves trace information for current thread
    correlation = Datadog.tracer.active_correlation
    {
      # Adds IDs as tags to log output
      dd: {
        trace_id: correlation.trace_id.to_s,
        span_id: correlation.span_id.to_s,
        env: correlation.env.to_s,
        service: correlation.service.to_s,
        version: correlation.version.to_s
      },
      ddsource: ["ruby"],
      params: event.payload[:params].reject { |k| %w(controller action).include? k }
    }
  end

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Suppress logger output for ActiveRecord and ActionView
  config.active_record.logger = nil
  config.action_view.logger = nil

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Set the logging destination(s)
  config.log_to = %w[stdout file]

  # Show the logging configuration on STDOUT
  config.show_log_configuration = true
end
