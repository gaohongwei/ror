Scoping the queries
  If your administrators have different access levels, 
  you may sometimes want to scope what they have access to.
  Assuming your User model has the proper has_many relationships, 
  you can simply scope the listings and finders like so:

  ActiveAdmin.register Post do
    scope_to :current_user # limits the accessible posts to `current_user.posts`

    # Or if the association doesn't have the default name:
    scope_to :current_user, association_method: :blog_posts

    # Finally, you can pass a block to be called:
    scope_to do
      User.most_popular_posts
    end
  end
  You can also conditionally apply the scope:

  ActiveAdmin.register Post do
    scope_to :current_user, if:     proc{ current_user.limited_access? }
    scope_to :current_user, unless: proc{ current_user.admin? }
  end
Eager loading
  Eliminate N+1 queries by eager loading associations:

  ActiveAdmin.register Post do
    includes :author, :categories
  end

Customizing resource retrieval
  Our controllers are built on Inherited Resources,
  so you can use all of its features.

  If you need to customize the collection properties,
  you can overwrite the scoped_collection method.

  ActiveAdmin.register Post do
    controller do
      def scoped_collection
        end_of_association_chain.where(visibility: true)
      end
    end
  end

  If you need to completely replace the record retrieving code
  (e.g., you have a custom to_param implementation in your models),
  override the find_resource method on the controller:

  ActiveAdmin.register Post do
    controller do
      def find_resource
        scoped_collection.where(id: params[:id]).first!
      end
    end
  end

  Note that if you use an authorization library like CanCan,
  you should be careful to not write code like this,
  otherwise your authorization rules won’t be applied:

  ActiveAdmin.register Post do
    controller do
      def find_resource
        Post.where(id: params[:id]).first!
      end
    end
  end

Belongs To
  It’s common to want to scope a series of resources to a relationship. 
  For example a Project may have many Milestones and Tickets. 
  To nest the resource within another, you can use the belongs_to method:

  ActiveAdmin.register Project
  ActiveAdmin.register Ticket do
    belongs_to :project
  end
  Projects will be available as usual and tickets will be available by 
  visiting /admin/projects/1/tickets assuming that a Project 
  with the id of 1 exists. Active Admin does not add “Tickets” to 
  the global navigation because the routes can only be generated when there is a project id.

  To create links to the resource, you can add them to a sidebar 
  (one of the many possibilities for how you may with to handle your user interface):

  ActiveAdmin.register Project do

    sidebar "Project Details", only: [:show, :edit] do
      ul do
        li link_to "Tickets",    admin_project_tickets_path(resource)
        li link_to "Milestones", admin_project_milestones_path(resource)
      end
    end
  end

  ActiveAdmin.register Ticket do
    belongs_to :project
  end

  ActiveAdmin.register Milestone do
    belongs_to :project
  end
  In some cases (like Projects), there are many sub resources and 
  you would actually like the global navigation to switch 
  when the user navigates “into” a project. To accomplish this, 
  Active Admin stores the belongs_to resources in a separate menu which you can use if you so wish. To use:

  ActiveAdmin.register Ticket do
    belongs_to :project
    navigation_menu :project
  end

  ActiveAdmin.register Milestone do
    belongs_to :project
    navigation_menu :project
  end
  Now, when you navigate to the tickets section, 
  the global navigation will only display “Tickets” and “Milestones”. 
  When you navigate back to a non-belongs_to resource, it will switch back to the default menu.

  You can also defer the menu lookup until runtime so that 
  you can dynamically show different menus, 
  say perhaps based on user permissions. For example:

  ActiveAdmin.register Ticket do
    belongs_to :project
    navigation_menu do
      authorized?(:manage, SomeResource) ? :project : :restricted_menu
    end
  end
  If you still want your belongs_to resources to be available in 
  the default menu and through non-nested routes, 
  you can use the :optional option. For example:

  ActiveAdmin.register Ticket do
    belongs_to :project, optional: true
  end
