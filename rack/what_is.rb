##### What is a Rack #####
A minimal interface between webservers and Ruby frameworks.
The webservers need to support Ruby

##### How to use Rack #####
A Rack application can be defined as an object which responds to #call method. 
Provide an object that responds to the call method
  taking the environment hash as a parameter, 
  returning an array with three elements:
    [status, headers, body]
      The HTTP response code
      A Hash of headers
      Body
##### Samples #####
class JSONServer
  def call(env)
    [200, {"Content-Type" => "application/json"}, ['{ "message" : "Hello!" }']]
  end
end

JSONServer.new or 
app = Proc.new do |env|
    ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end

##### start rack #####
# config.ru
app = Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }
app = JSONServer.new
run app
or 
run a Rack application just with ruby command
Rack::Handler::WEBrick.run app 
Rack::Server.start app: app
Rack::Handler::Thin.run app

$ rackup config.ru
$ rackup

##### Rack Apps as Ruby Objects #####
class RackApp
  def self.call(env)
    [200, {"Content-Type" => "text/plain"}, ["Hello, Zaiste!"]]
  end
end

run RackApp

