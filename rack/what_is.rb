##### What is a Rack #####
A minimal interface between webservers and Ruby frameworks.
The webservers need to support Ruby

##### How to use Rack #####
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
Rack::Handler::WEBrick.run app 

$ rackup config.ru
$ rackup
