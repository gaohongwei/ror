https://github.com/omniauth/omniauth/wiki/setup-phase
http://www.createdbypete.com/articles/dynamic-omniauth-provider-setup/
########## setup in a class  ##########
Dynamic OmniAuth Provider Setup

I’m a real fan of OmniAuth gem but I think some of it’s more powerful features get overlooked. 
One of these features is the setup phase; the setup phase allows for 
  request-time modification of an OmniAuth strategy. 
  In this article I’m going to demonstrate how to dynamically set 
  the strategy options so your application users could 
  specify the API credentials used by OmniAuth.

We’ll be using Rails 4 and Omniauth 1.2 (versions at the time of writing). 
  We’ll use the Twitter strategy for the examples but the 
    same principles can be applied to any strategy.

The OmniAuth wiki provides an overview of the different ways you can use the setup phase, 
    in the wiki examples a lambda is used but we’ll be moving it 
    into a class called OmniauthSetup. Let’s configure OmniAuth to use the class.

# config/initializers/omniauth.rb
require 'omniauth_setup'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, setup: OmniauthSetup
end
Writing the class

The setup key tells OmniAuth to call our new class for the setup phase. 
  You can still include the key and secret here, they would be used as defaults 
  but you can leave them out if you don’t want to have a default defined here.

Time to expand our OmniauthSetup class to do something useful. For this example, 
  let’s assume we have a model called Account with an attribute called 
  subdomain where we store the subdomain for this account. We use a 
    subdomain because the OmniAuth routes aren’t easy to change, 
    so we use the subdomain in the request to find the account record in our database.

# lib/omniauth_setup.rb
class OmniauthSetup
  # OmniAuth expects the class passed to setup to respond to the #call method.
  # env - Rack environment
  def self.call(env)
    new(env).setup
  end

  # Assign variables and create a request object for use later.
  # env - Rack environment
  def initialize(env)
    @env = env
    @request = ActionDispatch::Request.new(env)
  end

  private

  # The main purpose of this method is to set the consumer key and secret.
  def setup
    @env['omniauth.strategy'].options.merge!(custom_credentials)
  end

  # Use the subdomain in the request to find the account with credentials
  def custom_credentials
    account = Account.find_by!(subdomain: @request.subdomain)
    {
      client_id: account.twitter_consumer_key,
      client_secret: account.twitter_consumer_secret
    }
  end
end
Let’s break this class down and see what’s going on:

OmniAuth expects our class to respond to .call and passes env as a parameter.
When we instantiate our class we create a request instance from the env. This will allow us to get the #subdomain later on.
The #setup method reaches inside the environment hash for omniauth.strategy to grab the current options. This would be the values you’ve already set in the omniauth initializer. It then merges in the hash returned from the hash returned by #custom_credentials.
We obtain the accounts custom credentials by simply finding the account in our database with a matching recording and then building a hash with those values.
So now if you start the OmniAuth sign in process from the accounts subdomain, OmniAuth sets up the oauth handshake to Twitter using the credentials stored against the account record in the database.

While this is a basic example of what you can do with the OmniAuth setup phase, hopefully it will inspire you to creativly exploit the OmniAuth setup phase in your own projects.

Written by Peter Rhoades on Sep 26, 2014
########## setup in a proc  ##########
This is a documentation stub and should be expanded. Feel free to help make it more robust!

The setup phase exists to allow for request-time modification of an OmniAuth strategy. Here's how you might use it for Twitter auth on a Rack app:

SETUP_PROC = lambda do |env| 
  request = Rack::Request.new(env)
  user = User.find_by_subdomain(request.subdomain)
  env['omniauth.strategy'].options[:consumer_key] = user.consumer_key
  env['omniauth.strategy'].options[:consumer_secret] = user.consumer_secret
end
   
use OmniAuth::Builder.new do
  provider :twitter, :setup => SETUP_PROC
end
As you can see, you can pass a Proc (or anything that responds to call) to the :setup option when you specify a strategy and it will be called before the request and callback phases. Here you will have access to the running strategy via env['omniauth.strategy'] and you can modify it how you like.

Here's another example of using Facebook auth on a Rails app that uses a helper to return an ActiveRecord object with attributes of the current domain:

include ApplicationHelper

SETUP_PROC = lambda do |env|
  req = Rack::Request.new(env)
  # Note client_id & client_secret for Facebook
  env['omniauth.strategy'].options[:client_id] = current_domain(req).fb_app_id
  env['omniauth.strategy'].options[:client_secret] = current_domain(req).fb_app_secret
end

# Note the below block is different for a Rails app
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, setup: SETUP_PROC
end
You can use setup phase without block – it will work too if setup option is found. In Rails app you pass setup option like this:

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, Config['appKey'], Config['appSecret'], :setup => true
end
and omniauth will look for route like '/auth/:provider/setup' which you can match to SessionsController for example:

match '/auth/:provider/setup' => 'sessions#setup'
In SessionsController#setup you can manage request options like this:

class SessionsController < ApplicationController
  def setup
    # in this example facebook keys for different site domains are stored in Config   
    request.env['omniauth.strategy'].options[:client_id] = Config[domain]['appKey']
    request.env['omniauth.strategy'].options[:client_secret] = Config[domain]['appSecret']
    render :text => "Omniauth setup phase.", :status => 404
  end
end
