  config.clear_action_items!

  action_item(only: :index) {
    link_to "new", new_project_ticket_path(params[:project_id]) if params[:project_id].present?
  }
  
  controller do
    def action_methods
      params[:project_id].blank? ? super - ['new'] : super
    end
  end
