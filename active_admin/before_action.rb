ActiveAdmin.register Product do
  before_create do |item|
    item.user = current_user
  end
  
  controller do
    def call_before_create(offer)
    end
    def create
      params[:item].merge!({ user_id: current_curator.id })
      create!
    end   
  end

  controller do
    skip_before_action :authorize_user!   
    
    before_action :assign_user, :only => :create # not working
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
