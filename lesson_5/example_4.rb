my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end

# line 1
#    Action: method call (each)
#    Object: Multidimensional Array
#    Side effect: None
#    Return Value: The original multidimensional array
#    Return value used: Assigned to my_arr
#
# line 2
#    Action: method call (each)
#    Object: subarray (arr)
#    Side effect: None
#    Return Value: the original subarray
#    Return value used: No
#
# line 2 - 6
#    Action: Block execution
#    Object: each item in the subarray (arr)
#    Side effect: None
#    Return value: None
#    return Value Used: No
#
# line 1 - 7
#    Action: Block Execution
#    Object: multidimensional array
#    Side effect: None
#    Return Value: the original multidimensional array
#    Return value used: Assigned to my_arr
#
# line 3 - 5
#    Action: If statement
#    Object: Each item in the subarray
#    Side Effect: None
#    Return value: nil
#    Return value used: no
#
# line 3
#    Action: comparison
#    Object: each item in the subarray
#    Side Effect: None
#    Return value: true if num > 5, else false
#    Return value used: yes, value printed if true
#
# line 4
#    Action: Method call (puts)
#    Object: Each item in the subarray
#    Side Effects: display value of each item in the subarray
#    Return Value: nil
#    Return value used: no
