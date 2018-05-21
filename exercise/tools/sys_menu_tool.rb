module ApplicationHelper 
  def menu_bar
      render 'shared/menu_db'       
      #render 'shared/menu_hash' 
  end  
  def search_area(caption_columns=nil)
    if user_signed_in?
      caption_columns||=@caption_columns
      render(partial: '/shared/search', 
        locals: {placeholder: tt('placeholder'),
          caption_columns:caption_columns})
    end
  end  
  def submit_button(f,label=tt('submit'))
    render 'common/submit', :f=>f,:label=>label
  end  
  def link_act(label, apath,opt={})
  	ar=apath.split('#')
  	if ar.size >1
  	link_to(label,{controller: ar[0], action: ar[1]},opt)	
  	else
  	link_to(label,apath,opt)	
  	end		
  end
end