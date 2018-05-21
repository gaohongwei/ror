Cookies
  Cookies are key-value data pairs stored in the user’s browser 
  until they reach their specified expiration date. 

  With each new request to your server, 
  browser will send along all the cookies and 
  you can access them in your controllers and views 
  like a normal hash. 

  cookies[:name] = { value: "cookies YUM", expires: Time.now + 3600}.
  cookies[:hair-color] = "blonde"
  cookies.delete(:hair-color)
  
For hash data
  saved_data = JSON.parse(cookies[:saved_data])
  data_to_save = {}
  cookies[:saved_data] = {value: data_to_save.to_json}
