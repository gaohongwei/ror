The Logger
http://railscasts.com/episodes/56-the-logger

ActiveRecord::Base.logger = YouLogger.new

In Rails 4 all 
replace Rails.logger in an initializer.

exception_logger
https://github.com/defunkt/exception_logger/tree/master

###### write to mutiple loggers
require 'singleton'
class Log2db < Logger
  def format_message(severity, timestamp, progname, msg)
    "wgh #{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
    Template.create(name:msg,subject:msg,body:msg)
  end
end

# initializer
logfile = File.open("#{Rails.root}/log/custom.log", 'a')  # create log file
logfile.sync = true  # automatically flushes data to file
CUSTOM_LOGGER = Log2db.new(logfile)  # constant accessible anywhere
Rails.logger.extend(ActiveSupport::Logger.broadcast(CUSTOM_LOGGER))

### use json/yaml format
class Log2json < Logger::Formatter
  def call(severity, timestamp, progname, message)
    {
      type: severity,
      time: timestamp,
      message: message
    }.to_yaml #to_json
  end 
end
config.log_formatter = Log2json.new # env


module SampleApp
  class Application < Rails::Application
    # other lines...
    config.log_level = :info
    config.logger = ActFluentLoggerRails::Logger.new
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Json.new
  end
end
###################
class Log2db < Logger
  def start
    @logging=true
  end
  def stop
    @logging=false
  end
  def format_message(severity, timestamp, progname, msg)
    "#{severity} #{timestamp} #{progname} #{msg}\n"
  end
  def add(severity, message = nil, progname = nil, &block)
    super unless @logging.nil? || !@logging
  end
end

class Log
  logfile = File.open("#{Rails.root}/log/custom.log", 'a')
  logfile.sync = true
  CUSTOM_LOGGER = Log2db.new(logfile)
  def self.start_old
    puts "==========start logging"
    ActiveSupport::Logger.module_eval do
      alias_method :add_org, :add
      define_method(:add) do |*args, &block|
        CUSTOM_LOGGER.add(*args, &block)
        super(*args, &block)
      end
    end
  end
  def self.start
    puts "==========start logging"
    CUSTOM_LOGGER.start
    Rails.logger.extend(ActiveSupport::Logger.broadcast(CUSTOM_LOGGER))
  end
  def self.stop
    puts "==============stop logging"
    CUSTOM_LOGGER.stop
  end
  def self.stop_old
    puts "==============stop logging"
    ActiveSupport::Logger.module_eval do
      define_method(:add) do |*args, &block|
        add_org(*args, &block)
      end
    end
  end
end
