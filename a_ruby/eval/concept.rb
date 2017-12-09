class A
  def self.print_me
    puts 'I am in class'
    self    
  end
  def print_me
    puts 'I am in object'
    self    
  end
end

obj = A.new
obj.instance_eval{ print_me }# I am in object
obj.class_eval{ print_me }   # I am in class
A.instance_eval{ print_me }  # I am in class
A.class_eval{ print_me }     # I am in class
