Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails
  # Agent should be set with an enviornment variable, but autodetect ECS/EC2 local
  unless ENV['DD_AGENT_HOST']
    if ENV['AWS_EXECUTION_ENV'] == 'AWS_ECS_EC2'
      require 'httparty'
      response = HTTParty.get('http://169.254.169.254/latest/meta-data/local-ipv4')
      c.tracer hostname: response.body
    else
      c.tracer hostname: 'agent'
    end
  end
  # Allow Datadog env to be set by environment
  unless ENV['DD_ENV']
    c.tracer env: 'ruby-shop'
  end
  c.tracer service: 'shop-frontend'
end
