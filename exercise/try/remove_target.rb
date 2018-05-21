def remove_target(nums,target) # remove zero
  len = nums.length
  last_index = 0
  nums.each do |num|
    next if num == target
    nums[last_index] = num
    last_index +=1
  end
  (last_index..(len-1)).each {|index| nums[index] = '*'}
end


nums = [1, 0,2,3,0,4,0]
target = 0
remove_target(nums,target)
nums