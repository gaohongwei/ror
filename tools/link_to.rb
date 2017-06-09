module ApplicationHelper
############## Public  ############## 
  def redirect_to_ns(obj,notice=nil)
    ns=get_namespace()
    if ns.nil?
      redirect_to obj, notice
    else
      redirect_to [ns,obj], notice  
    end    
  end
  def link_to_ns(value,obj)
    # This will only be used in index
    # other links will be created from link_to_controller_action
    # the controller can be: admin/menus or menus
    ns=get_namespace()
    if ns
      link_to value,[ns,obj] 
    else
      link_to value,obj
    end    
  end
  def edit_delete(id=nil,controller=nil,isbig=true)
    controller ||=get_controller_ns()
    id ||=get_id()
    link2edit(controller,id,isbig)+link2delete(controller,id,isbig)
  end
  def btn_new_child(id=nil,controller=nil,isbig=true)
    controller ||=get_controller_ns()
    id ||=get_id()
    label=tt('Add Child')
    data={pid:id}
    link2new(controller,isbig,label,data)
  end  
  def img_new_child(id=nil,controller=nil,isbig=true)
    controller ||=get_controller_ns()
    id ||=get_id()
    label=tt('Add Child')
    data={pid:id}
    img_new(controller,label,data)
  end    
  def btn_copy(id=nil,controller=nil,isbig=true)
    controller ||=get_controller_ns()
    id ||=get_id()
    label=tt('Copy')
    data={id:id}
    link2new(controller,isbig,label,data)
  end 
  def btn_delete(id=nil,controller=nil,isbig=true)
    controller ||=get_controller_ns()
    id ||=get_id()
    link2delete(controller,id,isbig)
  end 


  def link2new(controller,isbig=true,label=nil,data={})
    action='new';id=nil
  	link_to_controller_action(controller,action,label,id,isbig,data)
  end
  def link2index(controller,isbig=true,label=nil)
    action='index' ;id=nil   
  	link_to_controller_action(controller,action,label,id,isbig)
  end

  def link2show(controller,id,isbig=true,label=nil)
    action='show'      
  	link_to_controller_action(controller,action,label,id,isbig)
  end
  def link2edit(controller,id,isbig=true,label=nil)
    action='edit'      
  	link_to_controller_action(controller,action,label,id,isbig)
  end
  ################## Image for new/delete link 
  def img_new(controller,label=nil,data={})
    options={ controller:controller, action:'new'}
    label ||=tt(label)
    label=image_tag("icons/new.png", :alt => label, :title => label)
    unless(data.nil?||data.empty?)
      if(data.is_a?(Hash))
        options.merge!(data)      
      end
    end    
    link_to label, options
  end
  def img_delete(id=nil,controller=nil,isbig=true)
    controller ||=get_controller_ns()
    id ||=get_id() 
    label ||=tt('delete')    
    label=image_tag("icons/delete.png", :alt => label, :title => label)
    link_to label, 
       { :controller => controller, :action => 'destroy', :id => id }, 
       { :confirm => tt('sure')+'?', :method => :delete}
  end

  def link2delete(controller,id,isbig=true,label=nil)
    label ||=tt('delete')
  	link_to label, 
       { :controller => controller, :action => 'destroy', :id => id }, # your URL details
       { :confirm => tt('sure')+'?', :method => :delete, :class => 'btn btn-danger btn-small'}
  end
############## Private tool function ##############  
  def link_to_controller_action(controller,action,label=nil,id=nil,isbig=false,data={})
    if isbig
     css_class='btn btn-primary'
    else
     css_class='btn btn-small'
    end
    controller ||=get_controller_ns()
    id ||=get_id()    
    id=nil if action == 'new'
    action='new'  if action == 'copy'
    label ||=tt(action)     
    options={ 
      :controller => controller, 
      :action =>action}

    unless(id.nil?)
      options.merge!({:id=>id})
    end
    unless(data.nil?||data.empty?)
      if(data.is_a?(Hash))
        options.merge!(data)      
      end
    end
    #link_to label, options
    link_to label, options, :class => css_class  
  end  
############## Removed  ##############   
  def xedit_scope(controller,id,label,scope)
    data={:scope=>scope}
    isbig=true
    link_to_controller_action(controller,'edit',label,id,isbig,data)
  end  
end