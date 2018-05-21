
def bsearch(ar, target)
# assume ascend
  i_start=0
  i_end = ar.length - 1
  while ( true )
    i_mid = (i_start + i_end)/2
    break if i_mid >= i_end
    return i_mid if ar[i_mid] == target
    if ar[i_mid] > target
      i_start = i_mid
    else
      i_end = i_mid
    end
  end
  -1
end
ar = (1..10).to_a
target = 4
bsearch(ar, target)


def bsort(ar, i_start, i_end) # sort by frag
  return if (i_end-i_start) < 1 # len =1
  if ar.length == 1 # len =2
    ar[i_start] = [ar[i_start], ar[i_end]].min
    ar[i_end] = [ar[i_start], ar[i_end]].max
    return
  end
  pivot = ar.length/2
  bsort(ar, i_start, pivot)
  bsort(ar, pivot+1, i_end)
  bmerge(ar, i_start, pivot, i_end)
end
def bmerge(ar, i_start, pivot, i_end)

end