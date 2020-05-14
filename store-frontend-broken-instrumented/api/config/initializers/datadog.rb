Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails, {'analytics_enabled': true}
  # Make sure requests are also instrumented
  c.use :http, {'analytics_enabled': true}
  # Commented out the hostname so it can be set via environment variable
  # c.tracer hostname: 'agent'
  c.tracer env: 'ruby-shop'
end
