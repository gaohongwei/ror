def call_chain(obj, arr)
  Array(arr).inject(obj) { |o, a| o.send(*a) }
end

arr = [:to_i, [:+, 4], :to_s, [:*, 3]]
call_chain('1', arr)

def call_chain(obj, arr)
  out = obj
  arr.each do |arg|
    out = out.send(*arg) if out.respond_to?(*arg)
  end
  out
end

arr = [:to_i, [:+, 4], :to_s, [:*, 3], [:what, 10]]
call_chain('1', arr)
