https://github.com/activeadmin/activeadmin/issues/3673
# include moudles
  ActiveAdmin.register MyResource do
    include SharedAdmin
  end
# Create moudles  
  # app/controllers/concerns/shared_admin.rb
  # Module: common methods for ActiveAdmin resources
  module SharedAdmin
    extend ActiveSupport::Concern

    def self.included(base) #v1
      # Shared member action. Using "send" due to "member_action" is a private method
      base.send(:member_action, :shared_action) do
        render :text => 'Hello from shared action!'
      end
    end
    
    def self.included(base) #v2
      base.send(:action_item, :view_in_app, only: :show, if: proc{ resource.location }) do
        link_to 'View in Location context', [resource.location, resource]
      end
    end
  end


Source
  Link: https://github.com/activeadmin/activeadmin/blob/ed1fbca8c64af827616c58f274d7be256ca513b6/lib/active_admin/dsl.rb#L54
  module ActiveAdmin
    class DSL
      # Include a module with this resource. The modules's `included` method
      # is called with the instance of the `ActiveAdmin::DSL` passed into it.
      #
      # eg:
      #
      #   module HelpSidebar
      #
      #     def self.included(dsl)
      #       dsl.sidebar "Help" do
      #         "Call us for Help"
      #       end
      #     end
      #
      #   end
      #
      #   ActiveAdmin.register Post do
      #     include HelpSidebar
      #   end
      #
      # @param [Module] mod A module to include
      #
      # @return [Nil]
      def include(mod)
        mod.included(self)
      end
    end
  end
