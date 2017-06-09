
To render a partial in Rails 3 I do:

render 'my_partial', :my_object => my_value
To get partial's result as string I do:

render_to_string(:partial => 'my_partial', :layout => false, 
                 :locals => {:my_object => my_value})
                 


Sometimes you could do something like
 render_to_body "path_to_file"
and it skips layout but still you have to use instance variables inside your partial.                 
