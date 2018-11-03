ActiveAdmin.register Product do
  before_create do |item|
    item.user = current_user
  end
  
  controller do
    skip_before_action :authorize_user!   
    
    before_action :assign_user, :only => :create
    before_filter :my_filter, only: [:edit, :show]
    
    private
    def assign_user
      # resource not available
      # ActiveRecord::RecordNotFound (Couldn't find Project with 'id'=):
      resource.user = current_user
    end
    
    def my_filter
      Rails.logger.info "my post: '#{resource}'"
    end
    
  end  
  
end
