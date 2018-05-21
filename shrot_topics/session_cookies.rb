Cookies:
  if request.xhr?
    saved_data = JSON.parse(cookies[:saved_data])
  else
    data_to_save = {}
    cookies[:saved_data] = {value: data_to_save.to_json}
  end
