Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Silence the web console warnings
  config.web_console.whiny_requests = false

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

  ## Commenting out this line to fix build for M1 Macs: https://github.com/evilmartians/terraforming-rails/issues/34#issuecomment-872021786
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Quiet down logger level and disable fragment logging
  config.log_level = :info
  config.colorize_logging = false
  config.action_controller.enable_fragment_cache_logging = false

  # Flatten out the payload key for easier parsing
  payload_formatter = Proc.new do |log, logger|
    log_hash = log.to_h
    # The delete method can potentially return nil
    log_hash.merge!(log_hash.delete(:payload) || {})
    # Make sure the log level reflects the HTTP status
    if log_hash.has_key?(:status)
      case log_hash[:status]
      when 200
        log_hash[:level] = "INFO"
      when 302
        log_hash[:level] = "WARN"
      else
        log_hash[:level] = "ERROR"
      end
    end
    log_hash.to_json
  end
  config.rails_semantic_logger.format = payload_formatter

  # Set the logging destination(s)
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    config.log_to = %w[stdout]
    STDOUT.sync = true
    config.rails_semantic_logger.add_file_appender = false
    config.semantic_logger.add_appender(
      io: STDOUT,
      level: config.log_level,
      formatter: config.rails_semantic_logger.format,
      # We don't want any of the deface messages here for now
      filter: -> log { !log.message.to_s.match(/Deface: /) }
    )
  else
    config.log_to = %w[stdout file]
  end

  # Show the logging configuration on STDOUT
  config.show_log_configuration = true
end
