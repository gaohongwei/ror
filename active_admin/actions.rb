## Way 1
  controller do
    def action_methods
      params[:project_id].blank? ? super - ['new'] : super
    end
  end
## Way 2
  config.remove_action_item(:new)
  action_item(only: :index) {
    link_to "new", new_project_data_file_path(params[:project_id]) if params[:project_id].present?
  }
##
  actions :index, :edit
  config.remove_action_item(:new)
  config.clear_action_items!

  action_item {link_to "Assets" , "/admin/assets" }
  action_item(only: :index) { link_to "Do something else", some_path }
  action_item(only: :index) {
    link_to "new", new_project_ticket_path(params[:project_id]) if params[:project_id].present?
  }
  action_item only: [:edit, :show] do
    @post = Post.find(params[:id])
    link_to 'Publish', publish_admin_post_path(post), method: :put
  end
  action_item :view_site do
    link_to "create data_file", '/books/new'
  end
  action_item :view, only: :show do
    link_to 'View on site', post_path(post) if post.published?
  end

  config.display_action_items :index => :new, :edit => :destroy, :show => [:edit, :destroy, :custom_action]
