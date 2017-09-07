
=============Use helper method
include ApplicationHelper

Print a Rails configuration in console
Rails.application.config
Rails.application.config.action_mailer
Rails.application.config.<your_variable>
Rails.application.config.instance_variables

============= Routes
Rails.application.routes

In the Rails console, the variable app holds a session object 
on which you can call path and url helpers as instance methods. 
app
app.user_path(User.first)

=============Mongoid Config
Mongoid::Config.sessions => {"default"=>{"database"=>"aperture_development", "hosts"=>["localhost:27017"], "options"=>nil}}
Mongoid::Config.methods


=============Current Directory
Dir.pwd

=============Load/require
require_relative requires a file specifically pointed to relative to the file that calls it.
require requires a file included in the $LOAD_PATH.
