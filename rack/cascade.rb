Rack::Cascade tries a request on several apps, and 
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
run Rack::Cascade.new [API, Web]
