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

  class HelloWorld
  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when /hello/
      [200, {"Content-Type" => "text/html"}, ["Hello World!"]]
    when /goodbye/  
      [500, {"Content-Type" => "text/html"}, ["Goodbye Cruel World!"]]
    else
      [404, {"Content-Type" => "text/html"}, ["I'm Lost!"]]
    end
  end
end
run HelloWorld.new
