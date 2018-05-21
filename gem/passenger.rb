https://www.digitalocean.com/community/tutorials/how-to-setup-a-rails-4-app-with-apache-and-passenger-on-centos-6
First, the gem needs to be installed on the system:

gem install passenger 
Before the Apache module is compiled, two dependency packages need to be installed as well:

yum install curl-devel httpd-devel 
The environment is now ready for the compilation. The process takes a few minutes and it’s started by the following command:

passenger-install-apache2-module  
Note that this script will not install the module really. It will compile module’s binary and place it under 
gem’s path. The path will be printed on screen and it needs to be copy-pasted into Apache’s config file 
(/etc/httpd/conf/httpd.conf) manually.

The output will be similar to this one:

LoadModule passenger_module /usr/local/rvm/gems/ruby-2.0.0-p353/gems/passenger-
4.0.26/buildout/apache2/mod_passenger.so 
PassengerRoot /usr/local/rvm/gems/ruby-2.0.0-p353/gems/passenger-4.0.26 
PassengerDefaultRuby /usr/local/rvm/wrappers/ruby-2.0.0-p353/ruby 
Placing those lines at the bottom of the file will do just fine. Save the change and restart Apache:

service httpd restart 

/etc/httpd/conf/httpd.conf
#
# Load config files from the config directory "/etc/httpd/conf.d".
#
Include conf.d/five9.conf
Include conf.d/five9_redirects.conf
Include conf.d/passenger.conf

LoadModule ssl_module modules/mod_ssl.so
Include conf.d/five9-ssl.conf
