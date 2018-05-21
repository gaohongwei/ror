http://api.rubyonrails.org/classes/ActionView/PartialRenderer.html
https://apidock.com/rails/ActionController/Base/render
http://railscasts.com/episodes/100-5-view-tips

Summary:
render 'some_view'
render partial: 'some_view'
render file: 'view_file'
#look for a file view.html.erb and NOT _view.html.erb
render partial: 'some/path/to/my/partial', locals: { custom_var: 'Hello' }
render :template => "weblog/show", :locals => {:customer => Customer.new}
# Renders the template located in [TEMPLATE_ROOT]/weblog/show.r(html|xml) (in Rails, app/views/weblog/show.erb)

Debugging Variables in Views
  <%= debug @products %>
  <%= debug params %>
  <%= debug request.env %>

Render a partial to a string
  AbstractController::render_to_string
  partial_string = render_to_string(:partial => 'my_partial')

Whitespace in ERB Templates
  Use a dash at the beginning and end of an ERB tag
  <div id="products">
    <%- for product in @products -%>
      <h3><%=h product.name %></h3>
    <%- end -%>
  </div>


Rendering partials
  By default, the current layout is not used.

  # Renders the same partial with a local variable.
  render :partial => "person", :locals => { :name => "david" }

  # Renders the partial, making @new_person available through
  # the local variable 'person'
  render :partial => "person", :object => @new_person

  # Renders a collection of the same partial by making each element
  # of @winners available through the local variable "person" as it
  # builds the complete response.
  render :partial => "person", :collection => @winners

  # Renders a collection of partials but with a custom local variable name
  render :partial => "admin_person", :collection => @winners, :as => :person

  # Renders the same collection of partials, but also renders the
  # person_divider partial between each person partial.
  render :partial => "person", :collection => @winners, :spacer_template => "person_divider"

  # Renders a collection of partials located in a view subfolder
  # outside of our current controller.  In this example we will be
  # rendering app/views/shared/_note.r(html|xml)  Inside the partial
  # each element of @new_notes is available as the local var "note".
  render :partial => "shared/note", :collection => @new_notes

  # Renders the partial with a status code of 500 (internal error).
  render :partial => "broken", :status => 500

Rendering a template
  Template rendering works just like action rendering except that
  it takes a path relative to the template root.
  The current layout is automatically applied.
  # Renders the template located in [TEMPLATE_ROOT]/weblog/show.r(html|xml) (in Rails, app/views/weblog/show.erb)
  render :template => "weblog/show"
  # Renders the template with a local variable
  render :template => "weblog/show", :locals => {:customer => Customer.new}
Rendering an action
  Action rendering is the most common form and the type used automatically by Action Controller when nothing else is specified.
  By default, actions are rendered within the current layout (if one exists).
  # Renders the template for the action "goal" within the current controller
  render :action => "goal"
  # Renders the template for the action "short_goal" within the current controller,
  # but without the current active layout
  render :action => "short_goal", :layout => false
  # Renders the template for the action "long_goal" within the current controller,
  # but with a custom layout
  render :action => "long_goal", :layout => "spectacular"

Rendering a file
 # Renders the template located at the absolute filesystem path
  render :file => "/path/to/some/template.erb"
  render :file => "c:/path/to/some/template.erb"
  # Renders a template within the current layout, and with a 404 status code
  render :file => "/path/to/some/template.erb", :layout => true, :status => 404
  render :file => "c:/path/to/some/template.erb", :layout => true, :status => 404

  # Renders '{"name": "David"}'
  render :json => {:name => "David"}.to_json

    # Renders the clear text "hello world" with status code 200
  render :text => "hello world!"
  # Renders the clear text "Explosion!"  with status code 500
  render :text => "Explosion!", :status => 500
  # Renders the clear text "Hi there!" within the current active layout (if one exists)
  render :text => "Hi there!", :layout => true
  # Renders the clear text "Hi there!" within the layout
  # placed in "app/views/layouts/special.r(html|xml)"
  render :text => "Hi there!", :layout => "special"

Normal render
  format.json render :partial => "users/show.json"
  format.html { redirect_to @task, notice: 'Task was successfully created.' }
  format.json { render json: @task, status: :created, location: @task }

  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @user }
  end

  respond_to do |format|
    if @task.save
      format.html { redirect_to @task, notice: 'Task was successfully created.' }
      format.json { render json: @task, status: :created, location: @task }
      format.js
    else
      format.html { render action: "new" }
      format.json { render json: @task.errors, status: :unprocessable_entity }
      format.js
    end
  end
