Factory pattern
  Different cloud app types
  They have similar(but different) behavior
  Use the same logic in the main

So we have 
  class CloudApp; end
  class CloudApp1 < CloudApp
  class CloudApp2 < CloudApp
  class CloudApp3 < CloudApp

class CloudAppfactory
  def self.getApp(type)
    case type
    when 'app1'
      app = CloudApp1
    when 'app2'
      app = CloudApp2
    else
      nil
    end
  end
end
