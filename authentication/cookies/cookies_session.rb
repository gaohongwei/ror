Cookies
  Cookies are sent along with every request you make.
  Secret_key_base, used to encrypt data

  When this includes things like current_user_id, anyone can become whichever user they want!

  curl -I http://www.google.com | grep Set-Cookie
  request.session_options[:id]
  current_user = User.find_by_id(session[:current_user_id])
