def show
  @user = User.find(params[:id])
  respond_to do |format|
    format.js { render 'hello.js.erb' }
    format.js { render template: 'hello.js.erb' }    
  end
end


ERB
$('#dom').replaceWith("<%= j render 'partial' %>");

Slim
|
  $('#dom').replaceWith("#{j render 'partial'}")

j = escape_javascript
