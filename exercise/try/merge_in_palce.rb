require 'byebug'
def merge_in_place(nums1,nums2)
  len1 = nums1.length
  len2 = nums2.length
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
  #byebug
  if index2 > 0
    (index2..0).each do |index|
      nums1[index] = nums2[index2]
    end
  end
  nums1
end

nums1 = [1,3,5]
nums2 = [2,4,6,7,8]

out = merge_in_place(nums1,nums2)
