# https://github.com/mperham/sidekiq/wiki/Error-Handling
# https://github.com/mperham/sidekiq/wiki/Using-Redis

# Using an ENV variable
    heroku config:set REDIS_PROVIDER=REDISTOGO_URL

Using an initializer
# this goes in your initializer
# config/initializers/sidekiq.rb

# configure the location of Redis
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }
end

# Error handling
Sidekiq.configure_server do |config|
  config.error_handlers << Proc.new {|ex,ctx_hash| MyErrorService.notify(ex, ctx_hash) }
end

Sidekiq.configure_server do |config|
  config.death_handlers << ->(job, ex) do
    puts "Uh oh, #{job['class']} #{job["jid"]} just died with error #{ex.message}."
  end
end

Process Crashes
If the Sidekiq process segfaults or crashes the Ruby VM, 
any jobs that were being processed are lost. 
Sidekiq Pro offers a reliable queueing feature which does not lose those jobs.

After retrying so many times, Sidekiq will call the sidekiq_retries_exhausted 
hook on your Worker if you've defined it. 
The hook receives the queued message as an argument. 
This hook is called right before Sidekiq moves the job to the DJQ.
class FailingWorker
  include Sidekiq::Worker

  sidekiq_retries_exhausted do |msg, ex|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end
  
  def perform(*args)
    raise "or I don't work"
  end
end
