@ar=[ {name:'gwei',pay:20}, {name:'jeff',pay:30}, {name:'just',pay:40} ]

tpl="<% @ar.each do |e| %> name:<%=e[:name]%>, pay:<%=e[:pay]%> <% end %>"
render :inline =>tpl,:layout => "application"

template = ERB.new(tpl)
@ss=template.result(binding)


data = render_to_string( :action => :show,:layout => false)
render_to_string( template: 'menu/index', locals: {items: @items})


To render an action with no layout we can use
render :layout => false

To render an action with a specific layout
render :layout => 'projects'

#Dynamic Layouts
class ProjectsController < ApplicationController
  layout :user_layout
  def user_layout
    if current_user.admin?
      "admin"
    else
      "application"
    end
  end
end

#Controller-specific Layouts
app/view/layout/projects.html.erb
The layout will be used only by the projects controller.


http://railscasts.com/episodes/7-all-about-layouts
