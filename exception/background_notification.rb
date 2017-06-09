exception_notification
https://github.com/smartinez87/exception_notification
My Sample:
  ExceptionNotifier.notify_exception(Exception.new,
    :data => {:message => "This is raised by Kevin Wei"})  
    
Background Notifications

If you want to send notifications from a background process like DelayedJob, you should use the notify_exception method like this:

begin
  some code...
rescue => e
  ExceptionNotifier.notify_exception(e)
end
You can include information about the background process that created the error by including a data parameter:

begin
  some code...
rescue => exception
  ExceptionNotifier.notify_exception(exception,
    :data => {:worker => worker.to_s, :queue => queue, :payload => payload})
end
Manually notify of exception

If your controller action manually handles an error, the notifier will never be run. To manually notify of an error you can do something like the following:

rescue_from Exception, :with => :server_error

def server_error(exception)
  # Whatever code that handles the exception

  ExceptionNotifier.notify_exception(exception,
    :env => request.env, :data => {:message => "was doing something wrong"})
end
