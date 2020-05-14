Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails
  # Commented out the agent so we can set it with an enviornment variable
  # c.tracer hostname: 'agent'
  c.tracer env: 'ruby-shop'
end
