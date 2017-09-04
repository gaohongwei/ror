Calling a method that doesnt exist will fire up method_missing.
Since define_method happens to be private to Module, we need to use send to invoke it.
  
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
