
=============Use helper method
include ApplicationHelper

Print a Rails configuration in console
Rails.application.config.action_mailer
Rails.application.config.<your_variable>
Rails.application.config.instance_variables

=============Mongoid Config
Mongoid::Config.sessions => {"default"=>{"database"=>"aperture_development", "hosts"=>["localhost:27017"], "options"=>nil}}
Mongoid::Config.methods


=============Current Directory
Dir.pwd

=============Load/require
require_relative requires a file specifically pointed to relative to the file that calls it.
require requires a file included in the $LOAD_PATH.
