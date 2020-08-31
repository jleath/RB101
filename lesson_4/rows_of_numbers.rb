# 2   = 2
# 10  = 4    6
# 30  = 8    10    12
# 68  = 14   16    18    20

# for a given integer, n
# calculate the first item of the given row, save this is result
# make a copy of result named curr_value
# iterate n-1 times
#   add 2 to curr_value
#   add curr_value to result

def get_start_of_row(n)
  # start with a variable initialized to 2 named curr_start
  # iterate n-1 times
  #   add 2 to curr_start n times
  curr_start = 2
  curr_row = 1
  while curr_row < n
    curr_row.times do
      curr_start += 2
    end
    curr_row += 1
  end
  curr_start
end

puts get_start_of_row(1) == 2
puts get_start_of_row(3) == 8
puts get_start_of_row(2) == 4

def row_sums(n)
  result = get_start_of_row(n)
  curr_val = result
  (n-1).times do
    curr_val += 2
    result += curr_val
  end
  result
end

puts row_sums(1) == 2
puts row_sums(2) == 10
puts row_sums(3) == 30
puts row_sums(4) == 68