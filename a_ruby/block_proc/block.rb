def sort_ar(ar, &block)
  return ar.sort(&block)
end

block = Proc.new { |x,y| x <=> y }
ar = (1..10).to_a.shuffle
sort_ar(ar, &block)
# sort_ar(ar){|x,y| x <=> y}
