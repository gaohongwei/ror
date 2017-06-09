These applys to Enumerable and array
ar.empty?
ar.blank?
########## map ##########
ar.map(&:name)
ar.map{|x|x.name}
########## ar.any?, ar.all? ar.one? ar.none?##########
ar.all?
ar.none?
ar.one?
ar.any?
It takes a block
The default block {|x|x} if no block provided
The block returns a bool 

http://stackoverflow.com/questions/6245929/check-for-array-not-empty-any

>> a = []
=> []
>> a.empty?
=> true
>> a = [nil, false]
=> [nil, false]
>> a.empty?
=> false
>> a = [nil]
=> [nil]
>> a.empty?
=> false

>> a = []
=> []
>> a.any?
=> false
>> a.one?
=> false
>> a.all?
=> true
>> a.none?
=> true

>> a = [nil, true]
=> [nil, true]
>> a.any?
=> true
>> a.one?
=> true
>> a.all?
=> false
>> a.none?
=> false

>> a = [true, true]
=> [true, true]
>> a.any?
=> true
>> a.one?
=> false
>> a.all?
=> true
>> a.none?
=> false
