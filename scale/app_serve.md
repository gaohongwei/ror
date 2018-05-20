Unicorn vs. Puma vs. Passenger: which app server is right for you?
http://blog.scoutapp.com/articles/2017/02/10/which-ruby-app-server-is-right-for-you

1. Slow clients
  need buffering
  In the Ruby app server ecosystem, 
  both Puma and Passenger handle slow clients 
  in a similar fashion: request buffering. 
  A separate process downloads incoming requests. 
  Only when the request has completed is it 
  passed on to an available worker.

  Puma and Passenger are equipped to 
  handle slow clients. 
  Unicorn cannot help with slow clients by itself: 
  requests go directly to a worker process. 
  "You should not allow unicorn to serve clients outside of your local network".


2. Slow apps
  Such as complex image processing logic
  Multiple process

  If your app is running Ruby MRI (and that's most apps), 
  your app is subject to the global interpreter lock. 
  This means only one thread in a Ruby process can 
  execute your application code at any time. 

  To process more requests concurrently, 
  your app server must support clustering: 
  it must spawn multiple processes to 
  execute application code on the same host 
  across multiple requests.

  Puma, Passenger, and Unicorn all have clustering support.
  
3. Slow I/O
  Such big DB query
  The most efficient way to tackle slow I/O is multithreading. 
