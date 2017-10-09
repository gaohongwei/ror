  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  default_driver = :selenium 
  
#Capybara.default_driver = default_driver
Capybara.javascript_driver = default_driver
