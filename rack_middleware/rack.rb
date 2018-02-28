##### What is a Rack #####
A minimal interface between webservers and web application(RoR frameworks)
The webservers need to support Ruby

A Rack app
  divide a web request into separate stages
  take each middleware as a filter
  can be used to intercept a request and alter the response
  group and order modules, Ruby classes
  specify dependency between them

$ rake middleware
  Authentication
  Authorisation
  Caching
  Execution
##### list middleware in rack application #####
middleware = []
app = Rack::Builder.parse_file('config.ru').first

while(app)
 middleware << app.to_s
 app = app.instance_eval{@target} 
end

##### How to use Rack #####
A Rack application can be defined as an object which responds to #call method. 
Can be one middleware
Provide an object that responds to the call method
  taking the environment hash as a parameter, 
  returning an array with three elements:
    [status, headers, body]
      The HTTP response code
      A Hash of headers
      Body
#####Rack::Response #####
  Rack::Response
  Its object requires a response having each method
  Rack::Response.new(bodymap, status, headers).finish

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
$ rackup -p 3001

##### Rack Apps as Ruby Objects #####
class RackApp
  def self.call(env)
    [200, {"Content-Type" => "text/plain"}, ["Hello, Zaiste!"]]
  end
end

run RackApp

##### Class vs Object #####
A Rack object inside config.ru, 
will be reused as long as Rack application runs. 
It means that the content of instance variables will be carried 
between requests if not set otherwise. 

It is a better idea to always define #call as a class method, 
i.e. pass in the class instead of an object inside rackup configuration file.
