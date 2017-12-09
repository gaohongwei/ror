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

class_name = A
class_name.class_eval{
  def print_you
    puts "you are in object"
  end
}

class_name.instance_eval{
  def print_you
    puts "you are in class"
  end
}
A.new.print_you # you are in object
A.print_you # you are in class
