export EMAIL=me@gmail.com
export PASSWORD=mypwd

view ./config/application.rb
config.action_mailer.default_url_options = { :host => 'me.com' }
config.action_mailer.delivery_method = :smtp
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true

config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => 'me@gmail.com',
  :password             => 'pwd',
  :authentication       => "plain",
  :enable_starttls_auto => true
}

Or set up host/default_url_options and gmail account/password by the following way:
class ApplicationController < ActionController::Base
	before_filter :mailer_set_url_options

  def mailer_set_url_options
    # default_url_options Not working here. 
    # Have to move to config to work    
    #config.action_mailer.default_url_options = { host:'xietiao.herokuapp.com'}   
    #Or  request.host_with_port
    
    ActionMailer::Base.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => "gmail.com",
      :user_name            => ENV["EMAIL"],
      :password             => ENV["PASSWORD"],    
      :authentication       => "plain",
      :enable_starttls_auto => true
    }
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.default_url_options = { host:request.host_with_port,protocol: 'http'}    
  end
end

export PASSWORD='mypwd'

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.default_options = { from: Settings.email.email }
  config.action_mailer.smtp_settings = {
    user_name: Settings.email.email,
    password: ENV['password']||Settings.email.password,
    domain: Settings.email.domain,
    address: Settings.email.address,
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }

  # Exception Notification
  exception_recipients = %w(support@gmail.com)
  exception_sender     = 'support@gmail.com'
  config.middleware.use ExceptionNotification::Rack,
    email:
      {
        :email_prefix => "[PREFIX] ",
        :sender_address => %{"notifier" <#{exception_sender}>},
        :exception_recipients => exception_recipients,
        :delivery_method => :smtp,
        :smtp_settings => config.action_mailer.smtp_settings
      }
