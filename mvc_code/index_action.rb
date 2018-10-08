module CrudHelper
  # order
  # 1. customized variables, no method needed
  # 2. cfg variable if no customized variables
  # 3. params, and query
  # 4. instance names
  # 5. template and render

  def index_old
    load_objs # @objs = model() # User
    index_by()
    index_mine()
    index_search_paging() #common
    index_final() #common
  end
  def index_params
    #params.require(:data_file).permit(:description, :attach)
    params.permit(:scope)
    #params.require(:data_file).permit!
  end
  def index_search_paging
    psize=10
    if @is_es
      index_search_es
      index_paging_es(psize)
    else
      index_search_col
      index_paging_col(psize)
    end
  end
  def index_paging_col(psize)
    sort_column = sort_column(search_column)
    order_by=sort_column + " " + sort_direction
    @objs=@objs.order(order_by).page(params[:page]).per(psize)
  end
  def index_paging_es(psize)
    @objs = Kaminari.paginate_array(@objs).page(params[:page]).per(psize)
  end
  def index_search_es
    vaule=params[:search]
    value ||=session[:search_value]
    unless vaule.nil? || vaule.empty?
      session[:search_value]=value
      @objs = @objs.search(params)
    end
    params[:index_search]=@objs#map{|x|x.id}
  end
  def index_search_col
    vaule=params[:search]
    value ||=session[:search_value]
    unless vaule.nil? || vaule.empty?
      session[:search_value]=value
      condition = "#{search_column} like ?"
      @objs = @objs.where(condition, "%#{vaule}%")
    end
    #params[:index_search]=@objs#map{|x|x.id}
  end
  def index_by
    str_by=''
    pnames=get_params_with_id()
    pnames.each do |pname| # group_id
      pmode_name=pname.split('_').first # group
      #pmode=pmode_name.classify.constantize #Group
      method="by_#{pmode_name}" # by_group
      id=params[pname]  # User.by_group(1)
      if @objs.respond_to?(method) && id
        @objs=@objs.send(method,id)
        str_by +=".#{method}(#{id})"
        #params[:str_by]=str_by
      end
    end
    #params[:index_by]=@objs#map{|x|x.id}
  end
  def index_mine
    case params[:scope]
    when nil,''
    when 'my','own','mine'
      if @objs.respond_to?(:by_user) && current_user
        @objs = @objs.by_user(current_user.id)
      end
    when 'joined','join','member'
      if @objs.respond_to?(:by_group) && current_user
        gids_joined=current_user.joined_group_ids
        gids_owning =current_user.owning_group_ids
        gids=gids_joined + gids_owning
        #gids=current_user.group_ids
        @objs = @objs.by_group(gids)
      end
    end
    #params[:index_mine]=@objs#map{|x|x.id}
  end
#============== Index ==============
  def search_column()
    search_col =params[:search_column] || model_column_names[0]
  end
  def sort_column(deault_col)
    return deault_col if params[:sort].nil?||params[:sort].empty?
    model_column_names.include?(params[:sort]) ? params[:sort] : deault_col
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
