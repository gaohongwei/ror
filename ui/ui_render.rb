

Render
To store the result of the render to a string, 
you could try the render_to_string method of 

Render a partial to a string
AbstractController::render_to_string
partial_string = render_to_string(:partial => 'my_partial')

respond_to do |format|
  format.html # show.html.erb
  format.json { render json: @user }
end

format.json render :partial => "users/show.json"
format.html { redirect_to @task, notice: 'Task was successfully created.' }
format.json { render json: @task, status: :created, location: @task }

Render html/json
  def create
    @task = Task.new(params[:task])

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
  end
