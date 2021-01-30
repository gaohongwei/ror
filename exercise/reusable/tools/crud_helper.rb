module CrudHelper
  def search_column()
    search_col =params[:search_column] || model.column_names[1]   
  end 
  def caption_columns()
      capt_cols=[]
      @columns.each_with_index do |col,index|
        capt_cols<<[tt(@captions[index]),@columns[index]]
      end
      capt_cols
  end

  def index
    #set_objs
    session[:search_value]=params[:search]    
    @search_value||=session[:search_value]
    
    @columns =get_columns()
    @captions=get_captions()
    @caption_columns=caption_columns()
    condition = "#{search_column} like ?"
    @sort_direction = sort_direction
    @sort_column = sort_column(search_column)
    order_by=@sort_column + " " + sort_direction

    pname=get_para_name_with_id()
    if pname
      pmode_name=pname.split('_').first
      pmode=pmode_name.classify.constantize
      pobj=pmode.find(params[pname])
      objs=pobj.send(get_controller())
      if params[:search].nil?
        @objs = objs.order(order_by).page(params[:page]).per(10)  
      else
        @objs = objs.where(condition, "%#{params[:search]}%").order(order_by).page(params[:page]).per(10)  
      end
    else  
      if params[:search].nil?
        @objs = model
        .order(order_by).page(params[:page]).per(10)  
      else
        @objs = model.where(condition, "%#{params[:search]}%")
        .order(order_by).page(params[:page]).per(10)  
      end      
    end 
    #objs = <%= class_name %>.page(params[:page]).order(order_by)
   
    respond_to do |format|
      format.html # index.html.erb
      format.json {render json:@objs}     
    end    
  end
  def new  
    if(params[:id].nil?)
      @obj=model.send("new")
    else
      obj=model.send("find",params[:id])
      @obj=obj.dup      
      begin
        col_name=model.column_names[1]
        @obj[col_name]="copy "+obj[col_name]
      rescue StandardError => e
        error=e.message  
        error +="first col_name=#{col_name}"
        flash[:notice]=error
      end 
    end    
  end
  def create
    @obj=model.send("new",get_params) 
    fill_user_id()
    before_save()
    if @obj.save
      after_create      
      redirect_to_ns @obj, notice: tt('created')
    else
      render action: 'new'
    end        
  end
# show, edit omitted
  def update
    fill_user_id()  
    begin 
      before_save()        
      if @obj.update_attributes(get_params)   
      #f @obj.update(get_params)      
      #render :show
        after_update
        redirect_to_ns @obj, notice: tt('updated')
      else
        render action: 'edit'
      end
    rescue StandardError => e
      flash[:error]=e.message
      render action: 'edit'
    end

  end
  def destroy
    @obj.destroy
    redirect_to action: "index", notice: tt('destroyed')
  end
private
  def before_save()
  end
  def after_create # need to override
    after_save
  end
  def after_update # need to override
    after_save
  end  
  def after_save # need to override
  end    
  def modelname
    #@modelname ||=controller_name.classify
    @modelname ||=get_controller().classify           
  end
  def model
    # Equivalent of @house_buyers = HouseBuyer.find(:all)
    # objects = controller_name.classify.constantize.all    
    #res_name=self.class.name.sub("Controller", "")
    #@model=res_name.singularize      
    @model ||=modelname.constantize   
    #@mode =Kernel.const_get(@modelname)  
  end
  def set_obj
    instance_variable_set("@obj", model.find(params[:id]))
  end
  def set_objs
    params[:page] ||=1    
    instance_variable_set("@objs", model.all)
  end
  def sort_column(deault_col)
    model.column_names.include?(params[:sort]) ? params[:sort] : deault_col
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  def fill_user_id()
    if @obj.respond_to?(:user_id) && current_user
      @obj.user_id=current_user.id 
    end 
  end
      
end