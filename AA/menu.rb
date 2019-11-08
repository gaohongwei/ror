https://activeadmin.info/2-resource-customization.html#customize-the-menu

Customize the Menu
  The resource will be displayed in the global navigation by default.
  To disable the resource from being displayed in the global navigation:

  ActiveAdmin.register Post do
    menu false
  end
  The menu method accepts a hash with the following options:

  :label - The string or proc label to display in the menu. 
    If it’s a proc, it will be called each time the menu is rendered.
  :parent - The string id (or label) of the parent used for this menu
  :if - A block or a symbol of a method to call to decide if the menu item should be displayed
  :priority - The integer value of the priority, which defaults to 10
Labels
  To change the name of the label in the menu:

  ActiveAdmin.register Post do
    menu label: "My Posts"
  end
  If you want something more dynamic, pass a proc instead:

  ActiveAdmin.register Post do
    menu label: proc{ I18n.t "mypost" }
  end
Menu Priority
  Menu items are sorted first by their numeric priority, then alphabetically. 
  Since every menu by default has a priority of 10, the menu is normally alphabetical.

  You can easily customize this:

  ActiveAdmin.register Post do
    menu priority: 1 # so it's on the very left
  end
Conditionally Showing / Hiding Menu Items
  Menu items can be shown or hidden at runtime using the :if option.

  ActiveAdmin.register Post do
    menu if: proc{ current_user.can_edit_posts? }
  end
  The proc will be called in the context of the view, 
  so you have access to all your helpers and current user session information.

Drop Down Menus
  In many cases, a single level navigation will not be enough to manage a large application. 
  In that case, you can group your menu items under a parent menu item.

  ActiveAdmin.register Post do
    menu parent: "Blog"
  end
  Note that the “Blog” parent menu item doesn’t even have to exist yet; it can be dynamically generated for you.

Customizing Parent Menu Items
  All of the options given to a standard menu item are also available to parent menu items. 
  In the case of complex parent menu items, you should configure them in the Active Admin initializer.

  # config/initializers/active_admin.rb
  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add label: 'Blog', priority: 0
    end
  end

  # app/admin/post.rb
  ActiveAdmin.register Post do
    menu parent: 'Blog'
  end
Dynamic Parent Menu Items
  While the above works fine, what if you want a parent menu item with a dynamic name? 
  Well, you have to refer to it by its :id.

  # config/initializers/active_admin.rb
  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add id: 'blog', label: proc{"Something dynamic"}, priority: 0
    end
  end

  # app/admin/post.rb
  ActiveAdmin.register Post do
    menu parent: 'blog'
  end
Adding Custom Menu Items
  Sometimes it’s not enough to just customize the menu label. In this case, 
  you can customize the menu for the namespace within the Active Admin initializer.

  # config/initializers/active_admin.rb
  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add label: "The Application", url: "/", priority: 0

      menu.add label: "Sites" do |sites|
        sites.add label: "Google",
                  url: "http://google.com",
                  html_options: { target: :blank }

        sites.add label: "Facebook",
                  url: "http://facebook.com"

        sites.add label: "Github",
                  url: "http://github.com"
      end
    end
  end
  This will be registered on application start before your resources are loaded.
