Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails
  # commented out hostname, use environment variable instead
  #c.tracer hostname: 'agent'
  c.tracer env: 'ruby-shop'
  c.tracer service: 'shop-frontend'
end
