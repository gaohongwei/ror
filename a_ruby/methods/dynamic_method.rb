##### define_method ##### 

define_method is a private method defined in Module class 
which you can use to create methods dynamically. 
To use define_method, you call it with the name of the new method and a block where the parameters of the block 
become the parameters of the new method. 

What is the difference between using def to create a method and define_method? 
There’s not much difference except define_method takes a variable

Since define_method happens to be private to Module, we need to use send to invoke it.
    
##### method_missing ##### 
Calling a method that doesnt exist will fire up method_missing.
  
class Developer
  ["frontend", "backend"].each do |method|
    define_method "coding_#{method}" do
      p "writing " + method.to_s
    end
  end
end

class Developer
  def method_missing method, *args, &block
    return super method, *args, &block unless method.to_s =~ /^coding_\w+/
    self.class.send(:define_method, method) do
      p "writing " + method.to_s.gsub(/^coding_/, '').to_s
    end
    self.send method, *args, &block
  end
end
