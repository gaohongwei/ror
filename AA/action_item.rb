  config.remove_action_item(:new)
  action_item :additional_items, only: [:index] do
    # add more  action items
    project_id = params[:project_id] 
    if project_id.present?
      link_to "New Data Sheet",  new_project_data_file_path(project_id: project_id) 
    end
  end  
  action_item :additional_items, only: [:index] do
    # add more  action items
    project_id = params[:project_id] 
    if project_id.present?
      link_to "Data Files",  project_data_files_path(project_id: project_id) 
    end
  end
  
# https://github.com/activeadmin/activeadmin/issues/53
  actions defaults: false do |user|
    item 'View', optumadmin_user_path(user), class: 'member_link'
    item 'Edit', edit_optumadmin_user_path(user), class: 'member_link'
    item 'Delete', optumadmin_user_path(user), class: 'member_link', method: :delete
  end
