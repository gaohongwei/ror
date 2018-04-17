Install gems from local
##### in default location #####
  bundler package
  bundle install --local

  vender/cache

##### specific location in gem file #####    
  gem 'g1', path: 'vendor/gems/abc-0.0.3'
  gem 'g2', path: 'lib/gems'
