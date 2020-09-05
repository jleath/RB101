[[[1, 2], [3, 4]], [5, 6]].map do |arr|
  arr.map do |el|
    if el.to_s.size == 1
      el + 1
    else
      el.map do |n|
        n + 1
      end
    end
  end
end

# line 1:
#    Action: method call (map)
#    Object: Original Multidimensional Array
#    Side Effect: None
#    Return Value: A copy of the array with each item incremented by one
#    Return Value Used: No
#
# line 1 - 11:
#    Action: Outer Block Execution (map)
#    Object: Original Multidimensional Array
#    Side Effect: None
#    Return Value: A copy of the array with each item incremented by one
#    Return Value Used: Used by top level map for transformation
#
# line 2:
#    Action: Method Call (map)
#    Object: Each subarray (first nested subarrays)
#    Side Effect: None
#    Return Value: A copy of the subarray with all items incremented by one
#    Return Value Used: Yes, used by top level map for transformation
#
# line 2 - 10:
#    Action: Second Level Block Execution (map)
#    Object: Each subarray (first nested subarrays)
#    Side Effects: None
#    Return Value: A copy of the subarray with all items incremented by one
#    Return Value Used: Yes, used by second level map for transformation
#
# line 6:
#    Action: method call (map)
#    Object: the most inner nested subarrays
#    Side Effect: None
#    Return Value: Flat Array of Integers
#    Return Value Used: Yes, used in second level map
#
# line 6-8:
#    Action: Block Execution (most inner nested map)
#    Object: the most inner nested subarrays
#    Side Effects: None
