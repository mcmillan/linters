require "sinatra"
require "resque"

configure do
  uri = URI.parse(ENV.fetch("REDISTOGO_URL"))
  REDIS = Redis.new(
    :host => uri.host,
    :port => uri.port,
    :password => uri.password
  )
  Resque.redis = REDIS
end

def app
  Sinatra::Application
end
