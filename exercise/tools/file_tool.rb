module ApplicationHelper 
  def save_file(fname,text)
    #File.open(fname, 'w') { |file| file.write(text) }
    File.write(fname,text)
  end
  def save_partial(fname,text)
    fname="app/views/widget_partials/"+fname
    save_file(fname,text)
  end
end