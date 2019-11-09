Custom Controller Actions

Modifying the Controller
  ActiveAdmin.register Post do
  belongs_to :project
  actions :new, :create
  permit_params :title, :short_description, :description
    
    controller do
      # This code is evaluated within the controller class

      def define_a_method
        # Instance method
      end
    end
  end

Action Items
  To include your own action items (like the New, Edit and Delete buttons), add an action_item block. The first parameter is just a name to identify the action, and is required. For example, to add a “View on site” button to view a blog post:

  action_item :view, only: :show do
    link_to 'View on site', post_path(post) if post.published?
  end

  Actions items also accept the :if option to conditionally display them:

  action_item :super_action,
              only: :show,
              if: proc{ current_admin_user.super_admin? } do
    "Only display this to super admins on the show screen"
  end
  By default action items are positioned in the same order as they defined (after default actions), but it’s also possible to specify their position manually:

  action_item :help, priority: 0 do
    "Display this action to the first position"
  end
  Default action item priority is 10.

Add a collection action
  ActiveAdmin.register Post do
    collection_action :import_csv, method: :post do
      # Do some CSV importing work here...
      redirect_to collection_path, notice: "CSV imported successfully!"
    end
  end

  Route: /admin/posts/import_csv pointing to the Admin::PostsController#import_csv controller action.

Member Actions, on a single resource

  ActiveAdmin.register User do
    member_action :lock, method: :put do
      resource.lock!
      redirect_to resource_path, notice: "Locked!"
    end
  end
  Route: /admin/users/:id/lock pointing to the Admin::UserController#lock controller action.

Rendering
  Custom controller actions support rendering within the standard Active Admin layout.

  ActiveAdmin.register Post do

    # /admin/posts/:id/comments
    member_action :comments do
      @comments = resource.comments
      #   It render app/views/admin/posts/comments.html.erb
    end

  end

  If you would like to use the same view syntax as the rest of Active Admin, you can use the Arbre file extension: .arb.

  For example, create app/views/admin/posts/comments.html.arb with:

  table_for assigns[:post].comments do
    column :id
    column :author
    column :body do |comment|
      simple_format comment.body
    end
  end

Page Titles
  The page title for the custom action will be the translated version of the controller action name. For example, a member_action named “upload_csv” will look up a translation key of active_admin.upload_csv. If none are found, it defaults to the name of the controller action.

  If this doesn’t work for you, you can always set the @page_title instance variable in your controller action to customize the page title.

  ActiveAdmin.register Post do

    member_action :comments do
      @comments   = resource.comments
      @page_title = "#{resource.title}: Comments" # Sets the page title
    end

  end

HTTP Verbs
  The collection_action and member_action methods both accept the :method argument to set the HTTP verb for the controller action and route.

  Sometimes you want to create an action with the same name, that handles multiple HTTP verbs. In that case, this is the suggested approach:

  member_action :foo, method: [:get, :post] do
    if request.post?
      resource.update_attributes! foo: params[:foo] || {}
      head :ok
    else
      render :foo
    end
  end
