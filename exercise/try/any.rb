def remove_target(ar, target)
  last_index = 0
  ar.each do |ele|
    next if ele == target
    ar[last_index] = ele
    last_index +=1
  end
  (last_index..(ar.length - 1)).each {|index| ar[index] = '*'}
end


ar = [0,1,0,3,4,2,0]
remove_target(ar, 0)


def remove_duplicate(ar)
  # on a sorted array
  last_index = 0
  ar.each do |ele|
    next if ele == target
    target = ele
    ar[last_index] = ele
    last_index +=1
  end
  (last_index..(ar.length - 1)).each {|index| ar[index] = '*'}
end

ar = [0,1,1,2,3,3]
remove_duplicate(ar, 0)