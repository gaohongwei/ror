def find_max_no1(ar)
  return nil if ar.length < 1
  max_no1 = ar[0]
  ar.each do |ele|
    max_no1 = ele if ele > max_no1
  end
  max_no1
end


def find_max_no2(ar) 
  return nil if ar.length < 2
  max_no1 = ar[0..1].max
  max_no2 = ar[0..1].min
  ar.each do |ele|
    if ele > max_no1
      max_no2 = max_no1
      max_no1 = ele
    elsif ele > max_no2
      max_no2 = ele
    end
  end
  max_no2
end


find_max_no1(ar) 
find_max_no2(ar) 

# complexity
def find_max_nth_max(ar,n) 
  return nil if ar.length < n
  max_no1 = ar[0,n].max
  max_non = ar[0,n].min
  ar.each do |ele|
    if ele > max_no1
      max_no2 = max_no1
      max_no1 = ele
    elsif ele > max_no2
      max_no2 = ele
    end
  end
  max_no2
end