ar.empty?
ar.any?
ar.none?
ar.one?
ar.all?


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
