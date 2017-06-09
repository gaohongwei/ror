###### member/collection
A member route will require an ID, because it acts on a member. 
A collection route doesn't because it acts on a collection of objects. 

  resources :syslogs, only: :index do
    collection do
      post :add_rcv
      post :add_app
    end
    member do
      delete :delete_rcv
      delete :delete_app
    end
  end

td = link_to "Delete ", delete_rcv_syslog_path(rcv['id']), method: :delete, data: {confirm: "You sure?"}
td = link_to "Delete ", delete_app_syslog_path(app['id']), method: :delete, data: {confirm: "You sure?"}

  def delete_rcv
    redircvt_to syslogs_path
  end

  def delete_app
    redircvt_to syslogs_path
  end
