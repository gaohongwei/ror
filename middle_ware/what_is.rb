interface between webservers and RoR frameworks.
group and order modules, Ruby classes 
specify dependency between them

Its constructor takes next application in stack as parameter 
It responds to “call” method, that takes environment hash as a parameter. 
The Returning value from this call is an array of: 
status code, environment hash and response body.
  
class Shrimp
 def initialize(app)
  @app = app
 end

 def call(env)
   status, headers, response = @app.call(env)
   [status, headers, response_body]
 end
end
