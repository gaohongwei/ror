ActiveAdmin.register Model::Info do
  menu false
  config.clear_action_items!
  config.filters = false

  actions :edit, :update

  controller do
    def edit
      item        = Item.find(params[:id])

      # Without the following line I get no layout, not even the application layout
      render layout: 'active_admin'
    end
  end
end
