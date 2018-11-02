Convert existing app to AA
  # rails generate devise:install
  # rails generate devise User
  rails generate migration AddSuperadminToUser

  config.default_namespace = false
  config.authentication_method = :authenticate_admin!
  config.current_user_method   = :current_user
  config.logout_link_path      = :destroy_user_session_path
  config.logout_link_method    = :delete

  class ApplicationController < ActionController::Base
    protect_from_forgery
    before_action :authenticate_user!

    def authenticate_active_admin_user!
      authenticate_user!
      unless current_user.superadmin?
        flash[:alert] = "Unauthorized Access!"
        redirect_to root_path
      end
    end
  end

  Add resource to AA
    rails generate active_admin:resource Book

Existing view/controller
  Old views will be rendered if exist
  Old controller will be ignored

Disable A Resource Page Menu Item
  We can display a menu if it is admin
  ActiveAdmin.register ClassName do
      menu false
  end

  ActiveAdmin.register ClassName do
    menu :if => proc{ can? :manage, ClassName }
  end
    
HOW TO START ACTIVE_ADMIN WITH EXISTING MODEL
# http://www.songjiayang.com/posts/how-to-start-active-admin-with-existing-model
  Step 1: Add admin to user table
    def change
      add_column :users, :admin, :boolean, :null => false, :default => false
    end
  Step 2: Reconfiguring ActiveAdmin
    # ==> File: config/initializers/active_admin.rb
    config.authentication_method = :authenticate_admin!
    config.current_user_method   = :current_user
    config.logout_link_path      = :destroy_user_session_path
    config.logout_link_method    = :delete

  Step 3: Add Admin Authenticate Function
    # ==> File: app/controllers/application_controller.rb
    def authenticate_admin!
      unless current_user.admin
        redirect_to root_path, :alert => "Unauthorized Access!"
      end
    end

  Step 4: Reconfiguring Routes
    # ==> File: config/routes.rb
    ActiveAdmin.routes(self)

  Step 5: Routes With Admin Namespace
    # ==> File: config/routes.rb

    namespace :admin do
      constraints AdminConstraint do
        # mount Sidekiq::Web => '/sidekiq'
      end
    end

    # ===> config/initializers/admin_constraint.rb

    class AdminConstraint
      def self.matches?(request)
        current_user = request.env['warden'].user
        current_user && current_user.admin?
      end
    end
