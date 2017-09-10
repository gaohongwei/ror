Method: Rack::Builder#map
#map(path, &block) ⇒ Object
Creates a route within the application.

Rack::Builder.app do
  map '/' do
    use Middleware
    run Heartbeat
  end
end

The use method can also be used here to specify middleware to run under a specific path:
This example includes a piece of middleware which will run before requests hit Heartbeat.
