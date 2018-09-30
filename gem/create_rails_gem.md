# Integrate Gem/Engine and main Rails app

## Overview
- [Paths](#paths)
- [Routes](#routes)
- [Add functionality to controller](#controllers)
- [Improving (Extending or overriding) Engine functionality](#extend-engine-class)
- [Helpers](#helpers)
- [Assets](#assets)


## Paths

* access gem root path from the app

```
spec = Gem::Specification.find_by_name("your_gem_name")
gem_root = spec.gem_dir
yaml_obj = YAML.load(gem_root + "/file_name.yaml")
```


<a name="routes"/>

## Routes

Routes inside an engine are isolated from the application by default.
The application and its engines can have routes with the same names.


Routes defined in engine:
```ruby
# /myengine/config/routes.rb

Myengine::Engine.routes do
  resources :articles
  
end

```

Mount engine to the main app:
```ruby
# config/routes.rb

Rails.application.routes.draw do
  # app routes
  
  #
  mount Myengine::Engine => "/myengine", :as => "myengine"

end

```

Engine's pages will have URL prefix 'myengine/'. For example, URL for articles page from Engine:
```
http://mysite.com/myengine/articles

```



### Access Engine's routes from the main app


Access engine's route from the main app view:
```ruby

# use the name specified in mount in 'as':  mount Myengine::Engine => "/myenginepath", :as => "myengine"
= link_to 'Articles from Engine', myengine.articles_path


# this will try to find route defined in the main app, NOT from engine
= link_to 'Articles', articles_path

```

from any place in app (in controller, or in a class in lib/ )
```ruby

Myengine::Engine.routes.url_helpers.articles_path

```


### Access main app's routes in Engine

routes defined in app:
```ruby
# config/routes.rb

Rails.application.routes.draw do
  resources :users

  # mount engine
  mount Myengine::Engine => "/", :as => "myengine"

end

```


Access app's routes from engine's view:
```ruby
# myengine/app/views/somedir/someview.html.haml

= link_to 'Users', main_app.users_path


```





### Merge engine and app routes

If you want the two sets of routes to be merged, you can use a non-isolated engine. 

Removing the isolated_namespace in the engine definition:
```ruby
# myengine/lib/myengine/engine.rb

module Myengine
  class Engine < Rails::Engine
    #isolate_namespace Myengine # remove this line
    ...
  end
end
```

Define routes in Engine with Rails.application.routes.draw, NOT Myengine::Engine.routes.draw:
```ruby
# myengine/config/routes.rb

Rails.application.routes.draw do
  resources :articles
  
end
```

Remove `mount` in the main app:
```ruby
App::Application.routes.draw do
  #mount Myengine::Engine => "/myengine" # remove this line
end

```

Now you can access routes from app and engine just using:
```
= link_to 'Articles', articles_path
```



Find more in [discussion on stackoverflow](http://stackoverflow.com/questions/7588870/engine-routes-in-application-controller#answer-7622755).


<a name="controllers"/>

## Controller

* We want to create a method in the Engine which will extend functionality of our app controller like this:

```
# Main app controller

class MyController < ApplicationController

  include UsefulController::Useful

  add_smth_useful :opt1, {opt1: v1, opt2: v2}

end

```


* Create method add_smth_useful in the Engine which will add action `myaction` to the main app controller


```
# Engine: app/controllers/useful_controller.rb

require 'active_support/concern'

module UsefulController
  module Useful
    extend ActiveSupport::Concern
    
    included do
      # method to add to controller
      def newmethod1
        ...
      end
    end

    module ClassMethods

      def add_smth_useful(arg1, options = {})
        
        # add method to the controller
        
        define_method("myaction") do
          # action code
          
          # render ...
        end
      end
    end

  end
end

```



<a name="extend-engine-class"/>

## Improving (Extending or overriding) Engine functionality

A common task after including Engine in your Rails app is extending some classes (models, controllers, other classes) defined in the Engine.

It can be done using Decorator pattern.

There are two options of extending a class defined in Engine:
- use Class@class_eval
- use ActiveSupport::Concern

 
For simple class modifications, use Class#class_eval. 

For complex class modifications, consider using ActiveSupport::Concern.
 
Read more in [Rails guides](http://edgeguides.rubyonrails.org/engines.html).


### use Class#class_eval to override class defined in Gem/Engine

```ruby
# lib/myengine/engine.rb
module Myengine
  class Engine < ::Rails::Engine
    isolate_namespace Myengine
 
    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end

```

in the Engine:
```ruby
# Myengine/app/models/article.rb
 
class Article < ActiveRecord::Base
  has_many :comments
  
  def summary
    "#{title}"
  end
end

```

in the main app:
```ruby
# MyApp/app/decorators/models/blorgh/article_decorator.rb
 
Myengine::Article.class_eval do
  # add new method
  def time_since_created
    Time.current - created_at
  end
  
  # override the method
  def summary
    "#{title} - #{truncate(text)}"
  end
  
end
```


### Extend Engine class using ActiveSupport::Concern

We have a class defined in Engine:
```ruby
# myengine/lib/myengine/mymodule/myclass.rb
module Myengine
  module Mymodule
    class Myclass
      include Myengine::Concerns::Mymodule::Myclass


    end
  end
end


```

Add concern to Engine:

```ruby
# myengine/lib/concerns/mymodule/myclass.rb

module Myengine::Concerns::Mymodule::Myclass
  extend ActiveSupport::Concern

  included do

  end

  def my_object_method
    'it is engine'
  end
  
  module ClassMethods
    # will be overridden in the main app
    def my_class_method
      []
    end

    
  end
end



```


Use concern in the main app:

```ruby
# myapp/lib/myengine/mymodule/myclass.rb

module Myengine
  module Mymodule
    class Myclass
      include Myengine::Concerns::Mymodule::Myclass

      # override class method
      def self.my_class_method
        ['1', '2', '3']
      end
      
      # override object method
      def my_object_method
        'this is app'
      end

    end
  end
end

```


### Extend Engine model class using ActiveSupport::Concern

We have a model defined in Engine (gem).

```ruby
# myengine/app/models/myengine/mymodel.rb
module Myengine
  class Myclass < ActiveRecord::Base
     


  end
end


```

One way to reopen a class in main app is defining an extension in app/extensions folder.
```ruby
# myapp/app/extensions/myengine/mymodel.rb

require Myengine::Engine.root.join('app/models/myengine/mymodel')


module MyengineExtensions
  extend ActiveSupport::Concern

  included do

    before_validation :_before_validation
    after_save :_after_save

    def _before_validation
      
    end

    def _after_save
      
    end
  end

  module InstanceMethods

  end

  module ClassMethods

  end
end

Myengine::Mymodel.send(:include, MyengineExtensions)


```


<a name="helpers"/>

## Use helpers defined in the Engine

* Isolated engine's helpers

Sometimes you may want to isolate engine, but use helpers that are defined for it. If you want to share just a few specific helpers you can add them to application's helpers in ApplicationController:

```
class ApplicationController < ActionController::Base
  helper MyEngine::SharedEngineHelper
end
```

If you want to include all of the engine's helpers, you can use the helper method on an engine's instance:

```
class ApplicationController < ActionController::Base
  helper MyEngine::Engine.helpers
end
```

It will include all of the helpers from engine's directory. Take into account that this does not include helpers defined in controllers with helper_method or other similar solutions, only helpers defined in the helpers directory will be included.




<a name="assets"/>

# Access Engine's assets from main app

A gem may come with assets - css, js or image files.

We want to use assets included in gem from main application.


* **Gem/Engine structure**:

* package.json

* app/assets/images/mygem/
  * img1.jpg

* app/assets/javascripts/mygem/
  * mygem1.js

* app/assets/stylesheets/mygem/
  * style1.scss


Place Gem's assets in folder 'mygem' so that they will be distinct from main app's assets.



* include asset files to be precompiled:

define precompiled assets in Gem:

config/initializers/assets.rb
```
Rails.application.config.assets.precompile += %w( mygem/style1.css )
Rails.application.config.assets.precompile += %w( mygem/mygem1.js )

```

/lib/mygem/engine.rb

```
module Mygem
  class Engine < ::Rails::Engine
    isolate_namespace Optimacms


    # for Rails 5
    config.enable_dependency_loading = false
    config.eager_load_paths += %W( #{Mygem::Engine.root}/lib )


    config.watchable_dirs['lib'] = [:rb] if Rails.env.development?
    config.watchable_dirs['app/helpers'] = [:rb] if Rails.env.development?

    config.autoload_paths += Dir["#{Mygem::Engine.root}/app/helpers/"]
    
    config.autoload_paths += Dir["#{Mygem::Engine.root}/lib/"]
    config.autoload_paths += Dir["#{Mygem::Engine.root}/lib/**/"]

    #config.autoload_paths += Dir["#{Mygem::Engine.root}/lib/concerns/"]
    #config.autoload_paths += Dir["#{Mygem::Engine.root}/lib/concerns/**/"]

    config.autoload_paths += Dir["#{Mygem::Engine.root}/lib/mygem/"]
    

    
    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        include ::Optimacms::Mycontroller

        ::ActionController::Base.helper Optimacms::Engine.helpers
      end
    end

    initializer "optimacms assets precompile" do |app|

      app.config.assets.precompile += %w(mygem/mygem1.js.css mygem/style1.css )


    end

  end
end

```



###  Use assets in Gem

Use Gem's assets in the Gem the same way as in usual Rails app.



* in view `app/views/mygem/folder1/example.html.haml`:
```
= javascript_include_tag "mygem/mygem1.js"

= stylesheet_link_tag    'mygem/style1', media: 'all'

```




### Use Gem's assets in main application.

* main app's js file `app/assets/stylesheets/myapp.js`
```
//= require mygem/mygem1.js
```


* main app's scss file `app/assets/stylesheets/myapp.scss`
```
...
@import "mygem/style1";
```



### Use npm packages in gem
A gem may include node packages with yarn.

In order to use js, css, image, font files in a node module with Rails assets pipeline we need to add those files to assets precompile paths:

in Gem file config/initializers/assets.rb:

```
Rails.application.config.assets.paths << Mygem::Engine.root.join('node_modules')
```


Now you can use files from a package in gem's assets files.


* package.json - this file is part of the Gem
```
{
  "name": "mygem",
  "version": "1.0.0",
  "main": "index.js",
  "repository": "git@github.com:maxivak/mygem.git",
  "author": "mmx <maxivak@gmail.com>",
  "license": "MIT",
  "dependencies": {
    "jquery": "3.2.1",
    "jquery-ui-dist": "1.12.1",
    "jquery-ujs": "1.2.2",
    "bootstrap": "4.1.0",
    "popper.js": "1.14.3",
    "font-awesome": "4.7.0"
  }
}


```



* use assets from node modules in Gem

* app/assets/javascripts/mygem/mygem1.js

```
//= require jquery/dist/jquery
//= require jquery-ujs
//= require jquery-ui-dist/jquery-ui



//= require popper.js/dist/umd/popper.js
//= require bootstrap/dist/js/bootstrap


````

* app/assets/stylesheets/mygem/style1.scss
```
...
// Bootstrap and its default variables
@import "bootstrap/scss/bootstrap";


```



* IMPORTANT! You may have problems if a node module refers to assets without using Rails asset helpers.

For example,
* node module includes css file which refers to images:

* css/some_module.css
```
.somestyle{
  background-image: url("../img/back1.jpg");
}

```

* module has images im `img` folder.

Then it will not work in Rails.

To fix this you have to change url(..) with asset-url(..) in css files in the module:
* rename css files to scss
* scss/some_module.scss:
```
.somestyle{
  background-image: asset-url("module-name/img/back1.jpg");
}

```



References:
* font-awesome package with Rails asset pipeline:
  * https://stackoverflow.com/questions/48572272/rails-asset-pipeline-working-with-fonts-and-yarn/49202226#49202226
  * https://stackoverflow.com/questions/42059621/rails-5-rails-assets-fontawesome-does-not-load-fonts/49202142#49202142

