def find_missed(nums, n)
  h={}
  (1..n).each {|x|h[x] = true}
  nums.each do |x|
    h[x] = false
  end
  h.select{|x| h[x] }

end
def find_dup(nums)
  h={}
  nums.each do |e|
    return e if h[e]
    h[e] = true
  end
  nil
end
nums = [1,2,3,4,5,3,4]
find_dup(nums)


def zero_move(ar, target)
  last  = 0
  index =0
  len=ar.length
  ar.each_with_index do|e,index|
    next if e == target
    ar[last] = e
    last +=1
  end
  (last..(len-1)).each {|index|ar[index] =0}
end

ar = [0, 1,0,2,0,3,4,0]
zero_move(ar,0)

def bsort(ar, start, stop)
  return if start == stop
  mid = (start + stop)/2
  bsort(ar, start, mid)
  bsort(ar, mid+1, stop)
  bmerge(ar, start, mid, stop)
end


def bmerge(ar, start, mid, stop)
  out = []
  index1 = start
  index2 = mid +1

  while(index1 <=mid && index2 <= stop)
    if ar[index1] < ar[index2]
      out <<  ar[index1]
      index1 +=1
    else
      out << ar[index2]
      index2 +=1
    end
  end
end


def bsearch(ar, target)
  start=0
  stop = ar.length - 1
  while(true)
    break if (stop - start) < 2
    puts "#{stop}, #{start}"
    mid = (start + stop)/2
    val = ar[mid ]
    # start   target  stop
    return mid if val == target
    if val < target
      start = mid
    else
      stop = mid
    end
  end
  -1
end




