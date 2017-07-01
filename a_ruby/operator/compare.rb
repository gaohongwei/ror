The spaceship <=> operator
puts 1 <=> 1 #ouputs 0
puts 3 <=> 4 #outputs -1
puts 4 <=> 3 #outputs 1

ar = ["abc", "another_key", "4567"] 
ar.sort{|x,y|x.length <=> y.length}

Get the following methods for free by including Comparable
>, < , >=, <=, ==, and between?
class Card
  include Comparable
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def <=> (other) 
    self.value <=> other.value
  end
end

a = Card.new(7)
b = Card.new(10)
c = Card.new(8)

puts a > b 
puts c.between?(a,b) 
puts [a,b,c].sort 
