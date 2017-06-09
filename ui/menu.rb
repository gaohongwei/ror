
module ApplicationHelper
	def link_act(label, apath,opt={})
		ar=apath.split('#')
		if ar.size >1
		link_to(label,{controller: ar[0], action: ar[1]},opt)	
		else
		link_to(label,apath,opt)	
		end		
	end

	def sys_menu
	[
		{
			caption:"Dropdown 1",
			position:'left',
			subitems:[
				{caption: "subitem 1", path:"backups#index"},
				{caption: "subitem 2", path:"backups#new"},
			]
		},
		{
			caption:"Dropdown 2",
			position:'left',
			subitems:[
				{caption: "subitem 1", path:"backups#index"},
				'---',
				{caption: "subitem 2", path:"backups#new"},
			]
		}
	]
	end
end


<% unless sys_menu.nil? ||sys_menu.empty? %>
  <div class="navbar navbar-static" style="margin: -2px">
    <div class="navbar-inner">
      <div class="container" style="width: auto;">
        <% sys_menu.each do |amenu| %>
          <ul class="nav pull-<%= amenu[:position].to_s%>">
            <li class="dropdown">
              <%= link_to("#{amenu[:caption]} <b class='caret'></b>".html_safe, "#", {class: "dropdown-toggle", 'data-toggle' => "dropdown"}) %>
              <ul class="dropdown-menu">
              <% amenu[:subitems].each do |item| %>
                <% unless item == "---" %>
                  <li>
                    <%= link_act(item[:caption], item[:path]) %>
                  </li>
                <% else %>
                  <li class="divider"></li>
                <% end %>
              <% end %>
              </ul>
            </li>
          </ul>
        <% end %>
      </div>
    </div>
  </div>
<% end %>
