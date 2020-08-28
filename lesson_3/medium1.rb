# QUESTION 1
# ----------------------------------------------------------------------------
10.times { |n| puts (" " * n) + "The Flintstones Rock!" }

# QUESTION 2
# ----------------------------------------------------------------------------
# The following will result in an error because (40 + 2) evaluates to an
# integer and you can't concatenate an integer directly to a string
# puts "the value of 40 + 2 is " + (40 + 2)
# You have to use the to_s method on the resulting integer
puts "The value of 40 + 2 is " + (40 + 2).to_s
# You could also use string interpolation or the format method
puts "The value of 40 + 2 is #{40 + 2}"
puts format("The value of 40 + 2 is %d", 40 + 2)

# QUESTION 3
# ----------------------------------------------------------------------------
def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# Number % divisor == 0 will return the remainder of number / divisor
# (as long as divisor is positive, if divisor is negative % will
# function as a true modulo function. If the remainder of number / divisor
# is 0, then divisor is a factor of number

# Ruby methods return the result of the last evaluation in the method, line 8
# is necessary to ensure that the method returns the array. Without this line,
# the method would return nil because that is the result of the loop

# QUESTION 4
# ----------------------------------------------------------------------------
# The return value of the two methods will be the same if they are given the same input.
# The difference is that rolling_buffer1 mutates the array that is passed in and
# rolling_buffer2 does not. 

# QUESTION 5
# ----------------------------------------------------------------------------
# The limit variable is not accessible from within the method. Methods cannot access
# local variables defined outside of their scope. They can access constants that are
# defined out of their scope, so changing the variable name to LIMIT will work.
# A potentially better solution would be to add an additional parameter to the definition
# of fib and pass in the limit.

# QUESTION 6
# ----------------------------------------------------------------------------
# p answer - 8 will print 34. 
# the line 'some_number += 8' is just a reassignment and does not affect the value
# of answer

# QUESTION 7
# ----------------------------------------------------------------------------
# Yes. The += and = operators work differently for hash and array accesses.
# The difference between a normal 'atomic' variable like an integer and 'compound'
# variables like a hash is that there is an extra level of indirection with compound
# variables. When we reassign an int, we are just changing the memory location that
# the local variable points at. When we reassign a key-value pair in a hash, we are 
# modifying the object that the local variable points at.

# QUESTION 8
# ----------------------------------------------------------------------------
# Evaluation proceeds as follows:
# rps(rps('paper', rps('rock', 'scissors')), 'rock')
# rps(rps('paper', 'rock'), 'rock')
# rps('paper', 'rock')
# 'paper'

# QUESTION 9
# ----------------------------------------------------------------------------
# The result will be no. the call to foo will return yes, which then becomes the
# value of param in bar.