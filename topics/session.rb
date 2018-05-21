2.1 What are Sessions?
  HTTP is a stateless protocol. 
  Sessions make it stateful.

  Without the idea of sessions, the user would have to 
  identify and  authenticate on every request. 

  A session usually consists of a hash of values and a session ID, 
  usually a 32-character string, to identify the hash. 

  Every cookie sent to the client's browser includes the session ID. 
  And the other way round: the browser will send it to the server 
  on every request from the client. 

  In Rails you can save and retrieve values using the session method:

  session[:user_id] = @current_user.id
  User.find(session[:user_id])
2.2 Session ID
  The session ID is a 32-character random hex string.
  The session ID is generated using SecureRandom.hex 
