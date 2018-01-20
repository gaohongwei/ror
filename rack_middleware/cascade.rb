Rack::Cascade 
It provides a way to combine Rack applications as a sequence. 
It takes an array of Rack applications as an argument. 

When a new request arrives, 
it will try to use the first Rack app in the array, 
if it gets a 404 response it will move to the next one. 

It tries a request on several apps, and 
returns the first response that is not 404 or 405 (or in a list of configurable status codes).

Rub Grape and Sinatra together using Rack::Cascade
https://gist.github.com/mbleigh/5341541

# config.ru
# run `rackup`
require 'sinatra'
require 'grape'

class Web < Sinatra::Base
  get '/' do
    "Hello world."
  end
end

class API < Grape::API
  get :hello do
    {hello: "world"}
  end
end

use Rack::Session::Cookie
run Rack::Cascade.new [API, Web, Rack::File.new("public")]
  
The last app in our array is Rack::File, 
which serves static files from the directory provided as an argument. 
If there is a request for a file from public directory, Rack::File will try to look for it. 
If not found, Rack::Cascade will move execution to next application from the list.
