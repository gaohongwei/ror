require 'link_to'
require 'page_tool'
require 'sys_menu_tool'

require 'view_get_from_db'  
=begin
  require 'view_def_hash'
  require 'sys_menu_hash'
  require 'view_get_from_hash'
=end
require 'file_tool'

module ApplicationHelper 
############## Public methods only ############## 
  def get_web_title()
    YAML.load(Setting[:browser_title])||tt('no_name')
  end
  def get_body_header()
    YAML.load(Setting[:body_header])||tt('no_name')
  end
  def show_article(article_id) 
    article = Article.find(article_id)
    article.content.html_safe 
  end
  def slide_article(article_id) 
    article = Article.find(article_id)
    content = article.content 
    #content=content.gsub("\r\n","\n").gsub("br /","\n")  
    content=content.gsub("<br />","`") 
    ar=[]
    bottom_string=article.title

    page = Nokogiri::HTML(content)  
    page.css('p').each do |p|
      #p.css("br").each do |e|
      content=p.content
      #content=content.gsub("<br />","\n") 
      #content=content.gsub("<br />","-")
      content.split('`').each do |e|
        ar<<e
      end     
    end 
    slide_array(ar,bottom_string)
  end

  def slide_array(data,bottom_string) 
    if data.nil? || data.empty?
      display(tt('no_data'))      
    else
      render partial:'shared/slide.array',
      locals:{data:data,bottom_string:bottom_string}
    end
  end      
  def slide_columns(data,columns,bottom_string)  
    if data.nil? || data.empty?
      display(tt('no_data'))      
    else
      render partial:'shared/slide.columns',
      locals:{data:data,columns:columns,bottom_string:bottom_string}
    end
  end 

  def photo_slide(photot_ary,bottom_string)  
     render partial:'shared/slide.photo',
     locals:{data:photot_ary,bottom_string:bottom_string}
  end
  def gallery_photo_slide(gallery_id,bottom_string)  
    if Gallery.where(id:gallery_id).exists?
      gallery=Gallery.find(gallery_id)
      render partial:'shared/slide.photo',
      locals:{data:gallery.media,bottom_string:bottom_string}
    else
      display('No data') 
    end
  end  
  def index_me(objs,sort_column,sort_direction, columns=nil, captions=nil, header=nil)
    myview=get_my_template('selfed')
    params[:myview]=myview   
    unless myview.nil? 
      render :template =>myview
    else    
      columns ||=get_columns()
      captions||=get_captions()
      actions ||=get_actions() 
      header  ||=get_page_header()         
      render 'shared/index', :objs=>objs, 
      :sort_column=>sort_column, :sort_direction=>sort_direction,
      :columns=>columns, :header=>header,:captions=>captions,:actions=>actions     
    end
  end
  def show_me(obj,columns=nil,captions=nil, header=nil)
    myview=get_my_template('selfed')
    params[:myview]=myview   
    unless myview.nil? 
      render :template =>myview
    else
      columns ||=get_columns()
      captions||=get_captions()
      actions ||=get_actions() 
      header  ||=get_page_header(obj,:dft)  
      render 'shared/show', :obj=>obj,:columns=>columns,
      :captions=>captions,:header=>header,:actions=>actions
    end
  end  
  def form_me(obj,columns=nil,captions=nil, header=nil)   
    myview=get_my_template('selfed')
    params[:myview]=myview   
    unless myview.nil? 
      render :template =>myview
    else      
      columns ||=get_columns()
      captions||=get_captions()
      actions ||=get_actions() 
      header  ||=get_page_header(obj,:dft)          
      render 'shared/form', :obj=>obj,:columns=>columns,
      :captions=>captions,:header=>header,:actions=>actions
    end
  end    
  def link2actions(actions=nil,id=nil,controller=nil,data={})
    actions ||=get_actions()
    controller ||=get_controller()
    id ||=get_id()   
    render 'shared/actions', :actions=>actions,:id=>id,:controller=>controller
  end  
  def link2action(act,id=nil,controller=nil,data={})
    isbig=true      
    #name:'group',action_scope:'index:::admin/users'
    # /groups/1/users
    act,scope,label,nested_res=act.split(':')
    unless scope.nil? || scope.empty?
      data.merge!({:scope=>scope})
    end
    if label.nil?||label.empty?
      label =tts("#{act} #{scope}") 
    else
      label = tts(label) 
    end 
    begin 
      if nested_res.nil?||nested_res.empty?
        link_to_controller_action(controller,act,label,id,isbig,data)  
      else
        controller||=get_controller_ns()
        id||=get_id()
        url="/#{controller}/#{id}/#{nested_res}"  
        params["#{act}_#{scope}_url"]=url                
        link_to label, url, class:'btn btn-primary'
      end

    rescue StandardError => e
      error=e.message
      error+="</br>controller=#{controller}" 
      error+="</br>act=#{act}" 
      error+="</br>label=#{label}" 
      error+="</br>id=#{id}</br>"                  
      logger.error(error)
      error.html_safe
    end

  end    
  def tt(key)
    key.blank?? '': t(key, :default => key)
  end 
  def lstt(key)
    return '' if key.empty?
    kk=key.downcase.singularize
    t(kk, :default => key)
  end   
  def tts(str,split_char=' ',keep_split_char=false)
    ar=str.split(split_char)
    ar=ar.map{|x|tt(x)}
    if keep_split_char
      return ar.join(split_char)
    else
      return ar.join('')
    end      
  end      
end