
Rails.cache.clear
rake tmp:clear
rake tmp:cache:clear
rake assets:clean

sudo rake tmp:clear

rake tmp:cache:clear
#clears out files that are stored on the filesystem 

Rails.cache.clear 
# do different things depending on your apps setting for 

Rails Tip #5: Clean Up Using Rake
Rails comes with a number of Rake tasks for cleaning up various temporary files 

rake tmp:clear          # Clear all files in tmp/
rake tmp:cache:clear    #Clear all files and directories in tmp/cache
rake tmp:sessions:clear #Clear all files in tmp/sessions
rake tmp:sockets:clear  #Clear all files in tmp/sockets
rake db:sessions:clear  #Rake can also clear the sessions table if you’re using one:

==================== cache ====================
# config
config/environments/production.rb
config/application.rb
config.action_controller.perform_caching = true
config.action_controller.page_cache_directory = 'my_public' # public by default
config.action_controller.page_cache_extension = 'cache' #html

==================== Page Caching ====================
Page caching can’t be applied to situation authentication
Enable page caching, 
class ProductsController < ActionController
  caches_page :index
  def index
    @products = Products.all
  end
  def create
    expire_page :action => :index
  end
end

The page cache directory is set to Rails.public_path (public) by default 

It helps avoid naming conflicts to chnage the default from public
but it will require web server reconfiguration to tell the web server for the cached files.

Page caching ignores all parameters. 
/products?page=1
/products?page=2
 both will be written out to the filesystem as products.html
==================== Action Caching ====================
Go to Rails rack first
Can run before_filter such as authentication
Serve the cache, similar to Page Caching
use expire_action instead of expire_page

class ProductsController < ActionController
  before_filter :authenticate
  caches_action :index
  def index
    @products = Product.all
  end
 
  def create
    expire_action :action => :index
  end
end


