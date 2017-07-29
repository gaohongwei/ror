def call_chain(obj, arr)
  Array(arr).inject(obj) { |o, a| o.send(*a) }
end

arr = [:to_i, [:+, 4], :to_s, [:*, 3]]
call_chain('1', arr)
