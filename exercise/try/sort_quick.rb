# https://gist.github.com/aspyct/3433278
def quicksort(ar, i_start, i_end)
  i_start ||=0
  i_end ||= ar.length -1
  return if i_start >= i_end
  index = partition(ar,i_start, i_end)
  quicksort(ar, i_start, index)
  quicksort(ar, index + 1, i_end)
end


def partition(ar,i_start, i_end)
    index = i_start + rand * (i_end - i_start)
    pivot = ar[index]
    left, right = i_start, i_end
    while(left < right)
        while(ar[left] > pivot)
            left +=1
        end
        while(ar[right] < pivot)
            right -=1
        end

        if(left < right)
            swap
            left +=1
            right -=1

        end
    end
    left
end

# Sample implementation of quicksort and mergesort in ruby
# Both algorithm sort in O(n * lg(n)) time
# Quicksort works inplace, where mergesort works in a new array

def quicksort_other_people(array, from=0, to=nil)
    to ||= array.count - 1

    return if from >= to

    # Take a pivot value, at the far left
    pivot = array[from]

    # Min and Max pointers
    min = from
    max = to

    # Current free slot
    free = min

    while min < max
        if free == min # Evaluate array[max]
            if array[max] <= pivot # Smaller than pivot, must move
                array[free] = array[max]
                min += 1
                free = max
            else
                max -= 1
            end
        elsif free == max # Evaluate array[min]
            if array[min] >= pivot # Bigger than pivot, must move
                array[free] = array[min]
                max -= 1
                free = min
            else
                min += 1
            end
        else
            raise "Inconsistent state"
        end
    end

    array[free] = pivot

    quicksort array, from, free - 1
    quicksort array, free + 1, to
end
