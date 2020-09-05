[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

# The map method is calledo n the multidimensional array [[1, 2], [3, 4]]
# Each subarray in this multidimensional array will be assigned to a variable named arr.
# arr.first will be evaluated, which will return the value of the first item in arr
# this first item will be passed into puts, which will print the value and return nil
# this nil is discarded and instead arr.first will be evaluated again.
# the evaluation of arr.first will be the return value of each iteration of the block
# so map will return an array containing the first item of each subarray in the original multidimensional array.
# as a side effect, it will also print the same values to the output one item at a time separated by newlines.

# Line 1:
#   Action: method call (map)
#   Object: Multidimensional Array
#   Side Effect: Print the first item of each subarray on its own line
#   Return Value: An array containing the first item of each subarray [1, 3]
#   Return Value Used?: No.

# Line 1-4:
#   Action: block execution
#   Object: Each sub-array (arr)
#   Side Effect: None
#   Return Value: the first item of arr
#   Return Value Used?: Yes, used by map

# Line 2
#   Action: method call (Array#first)
#   Object: each sub-array (arr)
#   Side Effect: None
#   Return value: the first item of sub-array
#   Return Value Used?: Yes, passed into puts to print

# Line 2
#   Action: method call (puts)
#   Object: the first item of each sub-array
#   Side Effect: output a string representation of an integer
#   Return Value: nil
#   Return Value Used?: No

# Line 3
#   Action: method call (Array#first)
#   Object: each sub-array (arr)
#   Side Effect: None
#   Return Value: the first item of sub-array
#   Return Value Used?: Yes, used as part of the return value of map

