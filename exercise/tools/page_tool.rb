module ApplicationHelper
############## All  page ############## 
  def random_name()
    (0...8).map { (65 + rand(26)).chr }.join
  end
  def display(str,size=3,isCenter=true)
    return '' if str.nil?||str.empty?
    if isCenter
      raw("<center><h#{size}>#{str}</h#{size}></center>")
    else
      raw("<h#{size}>#{str}</h#{size}>")      
    end
  end
  def display_error(str,size=3,isCenter=true)
      raw("<span class='alert alert-error'><h#{size}>#{str}</h#{size}></span>")
  end  
  def page_link(objs) #kaminari
    if objs.nil?
      ''
    else
      paginate(objs) 
    end
    # undefined method `current_page' for    
    #Kaminari.paginate_array(objs).page(params[:page]).per(10)
  end  
  def page_header(obj=nil,header=nil,size=3) 
    if obj.nil? 
      header=get_page_header()
    else
      header=get_page_header(obj,:dft)
    end
    display(header,3,false)
  end 
  def get_page_header(obj=nil,opt=nil)
    resource=get_resource()
    action=get_action()
    id=get_id()    
    #if action == 'new' && !id.nil?
    header="#{action} : #{resource}"
    
    header=tts(header)

    #dft_columns=get_columns(:dft)
    dft_columns ||=get_columns()   
    column=dft_columns[0]
    # copy: new?id=1
    unless obj.nil? || column.nil? 
      #header += obj[column]
      val=get_attr(obj,column)
      header +="(#{val})" unless val.nil?
    end
    header
  end 
  def get_my_template(path=nil)
    path||= 'selfed'
    ctl=get_controller()
    act=get_action()
    opt=get_scope() 
    opt= opt.nil?? "":".#{opt}"
    if ['new','edit'].include?(act)
      template="_#{ctl}.form"
    else
      template="_#{ctl}.#{act}#{opt}"
    end
    template=File.join(path,template)
    fname="#{template}.html.erb"      
    fname=File.join(Rails.root,'app', 'views',fname)
    params[:fname]=fname
    File.exist?(fname)? template:nil     
  end
  def get_my_view(path=nil)
    path||='selfed'
    ctl=get_controller()
    act=get_action()
    opt=get_scope()   
    fname="_#{ctl}.#{act}"
    fname="#{fname}.#{opt}" unless opt.nil?
    fname=File.join(path,fname)
    partial="#{fname}.html.erb"
    if File.exist?(partial)
      params[:partial]=partial
      params[:myview]=fname          
      return fname
    else 
      params[:partial]='DontExist'
      params[:myview]='DontExist'        
      return nil
    end
  end
############## Form page ############## 
  def parse_column_cfg(column_cfg_str)
    #return ['abc','123']
    params[:extra]=column_cfg_str
    return [] if column_cfg_str.nil? || column_cfg_str.empty?
    if '#' ==column_cfg_str[0] #
      # This is a string: #abc,123
      return column_cfg_str[1..-1].split(',')
    else # 'User.all'
      begin
        model,method=column_cfg_str.split('.')
        data=model.classify.constantize.send(method)
        #params[:data]=data.map{|x|x.name}
      rescue StandardError => e
        error=e.message  
        logger.error(error)
        data=nil
        flash[:error]=error
        params[:error]=error
      end
      return data
    end
  end

  def f_input(f,column,label=nil,adv=nil)
    column_org=column
    column,type,extra=column.split(':')
    if column.nil? || column.empty?
      return f.label label
    end 
    extra=nil if extra.nil?||extra.empty?
    
    label ||=column
    label =tt(label) 
    params[:type]=type
    opt={:label=>label}
    opt.merge!(adv) unless adv.nil? 
    adv=nil   
    unless type.nil?
      case type
      when 'c','checkbox','cb'
        adv={:as => :check_boxes}
        #adv[:collection]=['abc','123']
        adv[:collection]=parse_column_cfg(extra) if extra
      when 'co' # not working
        adv={:as => :check_boxes,:multiple => false}  
        adv[:collection]=parse_column_cfg(extra) if extra          
      when 'r','radio','rd'
        adv={:as => :radio} 
        adv[:collection]=parse_column_cfg(extra) if extra        
      when 'l','list','ls' #not working
        adv={:as => :select}  
        adv[:collection]=parse_column_cfg(extra) if extra               
      when 'h','hidden','hd'
        adv={:as => :hidden} 
      when 'text'
        adv={:as => :text}
      when 'rtf'
        adv={:as => :cktext_area}        
      else
      end
    end #unless
    opt.merge!(adv) unless adv.nil?
    if f.object.respond_to?(column)
      begin
        f.input column.to_sym,opt
      rescue StandardError => e
        error=e.message
        error+="</br>org=#{column_org}</br> column=#{column}" 
        logger.error(error)
        error.html_safe
      end
    else
      nil
    end
  end
  def f_checkbox(f,column,label=nil)
    f_input(f,column,label,{:as => :check_boxes})
  end
  def ptd(s)
    "<td>#{s}</td>"
  end
  def button_submit(f,label=tt('submit'))
    render 'shared/button_submit', :f=>f,:label=>label
  end
  def button_add(f,ham,label=tt('add'))
    #render 'shared/button_add', :f=>f,:label=>label,:ham=> ham
    klass='btn  btn-primary'
    f.link_to_add(label,ham, :class => klass)
  end
  def button_del(f,label=tt('remove'))
    #render 'shared/button_del', :f=>f,:label=>label
    klass='btn btn-danger btn-mini'
    f.link_to_remove(label,:class => klass)
  end
  # returns a link and icon to sort table columns
  def sort_col(direction, sort_col, cur_col,cur_head=nil)
    cur_head ||=cur_col
    cur_head= tt(cur_head)
    sortable(cur_col,cur_head) +  sort_icon(direction, sort_col, cur_col)
  end
  # returns a link to sort table columns 
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = params[:direction] == "asc" ? "desc" : "asc"
    link_to title, sort: column, direction: direction
  end
  
  def sort_icon(direction, column, table_column)
    return nil if column != table_column    
    return content_tag(:i, nil, {class: 'icon-chevron-up', style: 'float: right'}) if direction == 'asc'
    return content_tag(:i, nil, {class: 'icon-chevron-down', style: 'float: right'}) if direction == 'desc'
  end
  
  # display a message using the JQuery Toast Message plugin
  # types available: notice, success, warning an error
  def display_toast_message(message, type)
    return nil unless ['notice', 'success', 'warning', 'error'].include? type.to_s.downcase
    result = "<script>"
    result << "$().toastmessage('show#{type.to_s.capitalize}Toast', '#{message}');"
    result << "</script>"
    result.html_safe
  end 
############## Get from params ############## 
  def get_attr(obj,attrs)
    return "" if obj.nil?
    # attrs = obj.association.field_name:c, this is checkbox
    attrs,type=attrs.split(':') # remove column type
    ar=attrs.split('.')
    ar.each{|attr| obj=obj.send(attr) if obj.respond_to?(attr)}
    return obj
  end
  def get_controller_ns()
    # Ex: admin/media
    controller=params[:controller]
  end
  def get_controller()
    #controller=params[:controller]
    #controller=controller.split('/').last
    params[:controller_no_ns]=controller_name
    controller_name
  end
  def get_namespace()
    # Remove namespace Admin::Pages
    controller=params[:controller]
    #controller=controller.split('::').last
    controller=controller.split('/')
    if controller.size>1
      controller[0]
    else
      nil
    end
  end  
  def get_model()
    @model||=get_controller().classify.constantize
  end  
  def get_resource()
    get_controller().singularize
  end
  def get_action()
    params[:action]
  end
  def get_action_key()
    action=params[:action]
    (action == 'new')? 'edit':'new'
  end

  def get_id()
    params[:id]
  end
  def get_scope()
    params[:scope]
  end  
  def get_obj
    obj_name=''
    id=get_id()
    if id.nil?
      obj_name='HasData'
    end
  end
  def get_para_name_with_id()
    ids=params.keys.select{|x|x=~/_id$/}
    if ids.size > 0     
      return ids.first      
    else
      return nil
    end
  end


############## Removed  ############## 
  def zno_data()
    "<tr><td colspan='10'>#{tt('empty')}</td></tr>"
  end

  def ztable_header(direction, sort_col, columns)
    str='<table class="table table-striped table-bordered table-condensed">'
    str +='<thead>'
    str +='<tr>'
    columns.each do |cur_col|
      str +='<th>'
      str +=sort_col(direction, sort_col, cur_col)
      str +='</th>'     
    end
    str +="<th width='140px'><a href='#'>#{tt('actions')}</a></th>"
    str +='<vtr>'
    str +='</thead>'
  end
  def zindex_header(str,objs)
    page_header(str)+ search_area + page_link(objs)
  end  
end