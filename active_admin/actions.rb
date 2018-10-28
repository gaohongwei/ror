  actions :index, :edit
  # or: config.clear_action_items! 
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

  config.display_action_items :index => :new, :edit => :destroy, :show => [:edit, :destroy, :custom_action]

  controller do
    def action_methods
      params[:project_id].blank? ? super - ['new'] : super
    end
  end
