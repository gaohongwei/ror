http://railscasts.com/episodes/139-nested-resources

ActionController::Routing::Routes.draw do |map|
  map.resources :articles, :has_many => :comments, :shallow => true
  map.resources :comments, :only => [:index]
  map.root :articles
end

path
  article_comments_path(@article) %>
  new_article_comment_path(@article) %>
  edit_comment_path(comment) %>
  <%= link_to "Destroy", comment, :method => :delete, :confirm => "Are you sure?" %>
  <% form_for [@article, @comment] do |f| %>
