require 'byebug'
def merge_new_array(nums1,nums2)
    m = nums1.length
    n = nums2.length
    out = []

    index1=index2=0
    while(index1<m && index2<n)
        if ( nums1[index1] < nums2[index2])
            out << nums1[index1]
            index1 +=1
        else
            out << nums2[index2]
            index2 +=1
        end
    end

    if index2 < (n -1)
        (index2..(n-1)).each {|x| out << nums2[x]}
    end
    if index1 < (m -1)
        (index1..(m-1)).each {|x| out << nums1[x]}
    end
    nums1 =out
end

nums1 = [1,3,5]
nums2 = [2,4,6,8]
#merge(nums1,nums2)


def merge_in_place(nums1,len1,nums2, len2)
  nums1 +=Array.new(len2,0)
  index1 = len1 -1
  index2 = len2 -1
  index = len1 + len2 -1
  while(index1 >=0 && index2 >=0)
    if nums1[index1] > nums2[index2]
      nums1[index] = nums1[index1]
      index1 -=1
    else
      nums1[index] = nums2[index2]
      index2 -=1
    end
    index -=1
  end
  byebug
  if index2 > 0
    (index2..0).each do |index|
      nums1[index] = nums2[index2]
    end
  end
end

nums1 = [1,3,5]
nums2 = [2,4,6,8]
len1=3
len2=4
merge_in_place(nums1,len1,nums2, len2)