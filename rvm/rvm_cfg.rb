=================== Install RVM
curl 2>/dev/null >/dev/null || apt-get install curl -y
rvm  2>/dev/null >/dev/null || \curl -sSL https://get.rvm.io
rvm  2>/dev/null >/dev/null || \curl -sSL https://get.rvm.io | bash -s stable
rvm  2>/dev/null >/dev/null || \curl -sSL https://get.rvm.io | bash -s stable --rails
=================== Install Ruby New Version (Rails/gemset)
source /etc/profile.d/rvm.sh
rvm install 2.2.1
rvm use 2.2.1 #rvm list
rvm gemset create web1.0
rvm 2.2.1@web1.0 #rvm gemset list
rvm --default use 2.2.1@web1.0
rails -v 2>/dev/null >/dev/null ||
gem install --no-rdoc --no-ri rails -v 4.2.5
=================== 
sudo usermod -a -G rvm kwei
ruby -v
rails -v
rvm install ruby-1.9.3-p194
rvm use ruby-1.9.3-p194
ruby -v
rvm gemset list
rvm gemset create five9cms
rvm gemset list
rvm ruby-1.9.3-p194@five9cms
gem install rails -v 3.2.13
gem install passenger 
sudo yum install curl-devel httpd-devel
passenger-install-apache2-module  
view /etc/httpd/conf.d/passenger.conf

   LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.3-p194@five9cms/gems/passenger-4.0.53/buildout/apache2/mod_passenger.so
   <IfModule mod_passenger.c>
     PassengerRoot /usr/local/rvm/gems/ruby-1.9.3-p194@five9cms/gems/passenger-4.0.53
     PassengerDefaultRuby /usr/local/rvm/gems/ruby-1.9.3-p194@five9cms/wrappers/ruby
   </IfModule>


Old
#LoadModule passenger_module /home/deployer/.rvm/gems/ruby-1.9.3-p194@five9cms/gems/passenger-3.0.19/ext/apache2/mod_passenger.so
#PassengerRoot /home/deployer/.rvm/gems/ruby-1.9.3-p194@five9cms/gems/passenger-3.0.19
#PassengerRuby /home/deployer/.rvm/wrappers/ruby-1.9.3-p194@five9cms/ruby
LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.3-p194@five9cms/gems/passenger-3.0.19/ext/apache2/mod_passenger.so
PassengerRoot /usr/local/rvm/gems/ruby-1.9.3-p194@five9cms/gems/passenger-3.0.19
#PassengerRuby /usr/local/rvm/wrappers/ruby-1.9.3-p194@five9cms/ruby
PassengerRuby /etc/httpd/conf.d/ruby_wrapper

reboot
sudo service httpd restart
===================================================
adduser  web # ubuntu

Add a User to Multiple Groups
#ubuntu, centos
usermod -a -G rvm <username>
usermod -a -G ftp,admins,othergroup <username>
usermod -a -G rvm web


Add this to profile
[[ -s /usr/local/rvm/scripts/rvm ]] && source /usr/local/rvm/scripts/rvm
https://rvm.io/rubies

#install rvm and lastest ruby
rvm list known
rvm list 


curl -L https://get.rvm.io | sudo bash -s stable --ruby  # non root
curl -L https://get.rvm.io | bash -s stable --ruby  # with root

rvm install 2.1.1
rvm use ruby-2.1.1
rvm remove ruby-2.1.1
rvm use 1.9.3
rvm use 2.1.1

# Create new gemset
rvm gemset create rails410 rails403 rails320 # create a gemset
rvm 2.1.2@rails410  # specify Ruby version and our new gemset
gem install rails -v 4.1.0 # install specific Rails version
rvm 2.1.2@rails403
gem install rails -v 4.0.3 

# Create new gemset
rvm gemset create five9cms
rvm ruby-1.9.3-p545@five9cms
gem install rails -v 4.03
cd project
bundle install
edit .rvmrc
gem install passenger -v 3.0.19
yum install curl-devel httpd-devel 
passenger-install-apache2-module  

# Find ruby string and gem set
rvm list
rvm gemset list
rvm gemset list_all
rvm gemset create rails416
rvm gemset delete rails3213
rvm gemset rename current_gemset_name new_gemset_name
rvm  use 2.1.2@rails403
rvm  gemdir
rails -v


rvmrc
There are three different kinds of rvmrc files:
System wide configuration: /etc/rvmrc
User wide configuration: ~/.rvmrc
Project wide configuration:  .rvmrc

The most interesting one is the project .rvmrc. 
Every time you cd, RVM looks for a file called .rvmrc. 
If it finds it, it executes it.
