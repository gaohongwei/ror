http://railscasts.com/episodes/8-layouts-and-content-for
content_for :side
  Define a content_for block in index view
  Use the content in a application.html.erb

  You can refer to a placeholder in application.html.erb
  and define it later in index view

  index.html.erb
  <% content_for :side do %>
    ...
  <% end %>

  application.html.erb
  <div id="side">
    <%= yield(:side) || render(:partial => '...' %>
  </div>

yield
  yield is typically used in layouts.
  It tells Rails to put the content for this block at that place in the layout.  
  still be used to retrieve the stored content,
  but calling yield doesn’t work in helper modules, while content_for does.

  When you do yield :something associated with content_for :something, 
  you can pass a block of code (view) to display where 
  the yield :something is placed (see example below).
