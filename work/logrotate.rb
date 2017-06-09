Option 1: syslog + logrotate
You can configure rails, to use the systems log tools.

An example in config/environments/production.rb.

# Use a different logger for distributed setups
config.logger = SyslogLogger.new
That way, you log to syslog, and can use default logrotate tools to rotate the logs.

Option 2: normal Rails logs + logrotate
Another option is to simply configure logrotate to pick up the logs left by rails. 
On Ubuntu and Debian that would be, for example, in a file called /etc/logrotate.d/rails_example_com.

/path/to/rails.example.com/tmp/log/*.log {
    weekly
    missingok
    rotate 52
    compress
    delaycompress
    notifempty
    copytruncate
}
As per suggestions below, in Rails it is advised to use copytruncate, to avoid having to restart the Rails app.

Edit: removed "sharedscripts/endscript" since they are not used here and cause problems according to comment. 
And removed create 640 root adm as per comment suggested.

http://stackoverflow.com/questions/4883891/ruby-on-rails-production-log-rotation
