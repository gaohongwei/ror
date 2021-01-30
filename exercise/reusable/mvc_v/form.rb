form_tag/form_for( before Rails 5)
  <%= form_tag users_path do %>
    <%= text_field_tag :email %>
    <%= submit_tag %>
  <% end %>

  <%= form_for @user do |form| %>
    <%= form.text_field :email %>
    <%= form.submit %>
  <% end %>


form_with
remote: true, default
local: true

form_with without Model
  <%= form_with url: users_path do |form| %>
    <%= form.text_field :email %>
    <%= form.submit %>
  <% end %>

form_with with Model
  <%= form_with model: @user do |form| %>
    <%= form.text_field :email %>
    <%= form.submit %>
  <% end %>
  
  <%= form_with model: @user, local: true do |form| %>
    <%= form.text_field :email %>
    <%= form.check_box :send_welcome_email %>
    <%= form.submit %>
  <% end %>
