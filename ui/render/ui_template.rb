Tip #1 Debugging Variables in Views
<%= debug @products %>
<%= debug params %>
<%= debug request.env %>

Tip #2: Optional Locals in Partials
<%= display_product @product, :show_price => true %>

def display_product(product, locals = {})
  locals.reverse_merge! :show_price => false
  render :partial => product, :locals => locals
end

Tip #3: content_for :side
Define a content_for block in one view
And use it in a different view
index.html.erb
<% content_for :side do %>
  ...
<% end %>

application.html.erb
<div id="side">
  <%= yield(:side) || render(:partial => '...' %>
</div>

 yield can still be used to retrieve the stored content, 
 but calling yield doesn’t work in helper modules, while content_for does.


Tip #4: Whitespace in ERB Templates
Use a dash at the beginning and end of an ERB tag
<div id="products">
  <%- for product in @products -%>
    <h3><%=h product.name %></h3>
  <%- end -%>
</div>


http://railscasts.com/episodes/8-layouts-and-content-for
http://railscasts.com/episodes/100-5-view-tips
