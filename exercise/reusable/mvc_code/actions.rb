module CrudHelper
  # before_action/methods order
  # 1. set_customization
  # 2. set fallback variable/values if no customized variables
  # 3. params, and query
  # 4. instance names
  # 5. template and render
  def index
    #@column_ui
    # "email;vname|wname;groups.first.name|name;active"
    #render partial:"crud/index"
    finialize_index_ui
    respond_to do |format|
      format.html { render template: 'shared/index'}
      format.js   { render template: 'shared/index'}
    end
  end
#============== show,edit,destroy ==============
  def show
    render :template => my_template
  end
  def edit
    render :template => my_template
  end
#============== Create ==============
  def create
    @obj=@data_model.send("new",post_params)
    fill_user_id()
    if @obj.save
      after_create
    else
      #set_default
      #render action: 'new'
      # instance_variable_set("@#{obj_name}", @obj)
      # render :template => my_template
    end
  end
  def after_create
    #redirect_to_ns @obj, notice: tt('created')
    redirect_to_ns @obj
    flash_message(tt('created'))
  end
  def destroy
    msg = @obj.destroy ? tt('destroyed') : tt('destroy_failed')
    go_to_index_page(msg)
  end
#============== Update ==============
  def update
    fill_user_id()
    #begin
      if @obj.update_attributes(post_params)
      #f @obj.update(post_params)
        after_update
      else
        instance_variable_set("@#{obj_name}", @obj)
        render :template => my_template
      end
    #rescue StandardError => e
      #flash[:error]=e.message
      #render action: 'edit'
    #end
  end
  def after_update()
    redirect_to_ns @obj
    flash_message(tt('updated'))
  end

#============== New ==============
  def new
    pid=params[:pid]
    if pid # have parents
      @pobj||=@data_model.send("find",pid)
      unless can?(:write,@pobj)
        flash_message(tt('denied'))
        redirect_to(:back)
      end
    end
    new_obj()
    #params[:pobj]=@pobj.name if @pobj
    render :template => my_template
  end

  def new_obj
    if(params[:id].nil?)
      @obj=@data_model.send("new")
    else
      copy_obj(params[:id])
    end
    fill_pid(params[:pid])
    instance_variable_set("@#{obj_name}", @obj)
  end

  def copy_obj(id)
    obj=@data_model.send("find",id)
    @obj=obj.dup
    begin
      col_name=model_column_names[1]
      @obj[col_name]="copy "+obj[col_name]
    rescue StandardError => e
      error=e.message
      error +="first col_name=#{col_name}"
      flash[:notice]=error
    end
  end
end
