# include moudles
  ActiveAdmin.register MyResource do
    include SharedAdmin
  end
# Create moudles  
  # app/controllers/concerns/shared_admin.rb
  # Module: common methods for ActiveAdmin resources
  module SharedAdmin
    extend ActiveSupport::Concern

    def self.included(base)
      # Shared member action. Using "send" due to "member_action" is a private method
      base.send(:member_action, :shared_action) do
        render :text => 'Hello from shared action!'
      end
    end

  end

