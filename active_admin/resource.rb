# Available at /today/posts
ActiveAdmin.register Post, namespace: :today

# Available at /posts
ActiveAdmin.register Post, namespace: false
ActiveAdmin.register Post, as: "Article"
  Rename the Resource
  By default, any references to the resource (menu, routes, buttons, etc) in the interface will use the name of the class.
  You can rename the resource by using the :as option.

Nested Resource
  belongs_to :project
    routes: creates nested routes
    menu: put current resoure under the project menu

  belongs_to :project, optional: true
    routes: creates nested and non-nested 
    menus: put current resoure under the root menu

  navigation_menu :project

  Make nested resource work, 
    use default assoication name in AR
    dont rename the resuource in AA
