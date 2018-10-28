# Available at /today/posts
ActiveAdmin.register Post, namespace: :today

# Available at /posts
ActiveAdmin.register Post, namespace: false
ActiveAdmin.register Post, as: "Article"
  Rename the Resource
  By default, any references to the resource (menu, routes, buttons, etc) in the interface will use the name of the class.
  You can rename the resource by using the :as option.
