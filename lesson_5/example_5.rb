[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end

# line 1
#    Action: Method call (map)
#    Object: [[1, 2], [3, 4]]
#    Side Effect: None
#    Return Value: [[2, 4], [6, 8]]
#    Return value used: No
#
# line 1-5
#    Action: Block Execution
#    Object: Each subarray
#    Side Effects: None
#    Return Value: Each subarray with the items doubled
#    return value used: No
#
# line 2
#    Action; Method call (map)
#    Object: each subarray
#    Side effect: None
#    Return Value: an array with each item in the subarray doubled
#    return value used: Yes, used to build return value of outer block
#
# line 2-4
#    Action: Block Execution
#    Object: Each item in each subarray
#    Side Effects: None
#    Return Value: the item doubled
#    Return Value Used: Yes, used to build return value of inner block
#
# line 3
#    Action: Multiplication
#    Object: each item in each subarray
#    Side Effects: None
#    Return Value: each item doubled
#    Return Value used: Yes, used in return value of inner block
#
#
