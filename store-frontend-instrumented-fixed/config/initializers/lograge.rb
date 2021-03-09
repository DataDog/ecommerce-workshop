Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.colorize_logging = false

  config.lograge.custom_options = lambda do |event|
    correlation = Datadog.tracer.active_correlation
    {
      dd: {
        trace_id: correlation.trace_id,
        span_id: correlation.span_id
      },
      ddsource: ["ruby"],
      params: event.payload[:params].reject { |k| %w(controller action).include? k }
    }
  end
    # config.lograge.base_controller_class = ['ActionController::API', 'ActionController::Base', 'Spree::Preference', 'Spree::Base', 'Spree::Api::Base', 'Spree::Admin::Base', 'Spree::Core::Base', 'Spree::Preference::Base']
end
