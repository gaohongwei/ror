<% position='left' %>
<%# cache @cache_menu,skip_digest: true do%>
<%# cache 'menu-user',skip_digest: true do%>
<%# navbar-inverse navbar-fixed-top%>
<nav id="myNavbar" class="navbar navbar-default" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
  <div class="col-md-1"></div>
  <div class="col-md-10">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu">
        <% if tt('menu') == 'menu' || tt('menu') == 'Menu' %>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        <%else%>
          <span><%=tt('menu')%></span>
        <%end%>
      </button>
    </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="menu">
      <ul class="nav nav-tabs">
      <% (menus||[]).each do |amenu| %>
        <li class="dropdown">
          <%= link_to("#{tt(amenu[:name])} <b class='caret'></b>".html_safe, "#", {class: "dropdown-toggle", 'data-toggle' => "dropdown"}) %>
          <ul class="dropdown-menu">
            <% amenu.subs.each do |item| %>
            <% if item == "---" %>
              <li class="divider"></li>
            <% else %>
              <li>
                <%= link_to tt(item[:name]), item[:url] %>
              </li>
            <% end %>
            <% end %>
          </ul>
        </li>
      <% end %>
      </ul>
        <%############## Hard coded menu,singup/singin/logout ##############%>
        <%#= render 'layouts/menu_signin' %>
        <%############## Hard coded menu ##############%>
    </div> <%# collapse %>
  </div> <%# container %>
  </div>
  <div class="col-md-1"></div>
</nav>
<%# end %>
