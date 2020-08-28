# New things:
# String#gsub
# Range#cover
# Hash#assoc

# QUESTION 1
# ----------------------------------------------------------------------------

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# This code will print out:
# 1
# 2
# 2
# 3

# QUESTION 2
# ----------------------------------------------------------------------------

# ! represents several things in Ruby.
#   - It is the 'not' operator. This operator can be applied to a single
#     operand and will return the opposite of the operand's 'truthyness'.
#     For example, 
!false  # -> true
!true   # -> false
!nil    # -> true
!12     # -> false
#     The ! operator can be applied an arbitrary number of times, using the
#     operator twice will just cause the operand to be evaluated as a boolean
!!false # -> false
!!true  # -> true
!!12    # -> true
#     ! applied to false or nil will evaluate to true.
#     ! applied to any other value will evaluate to false.
#   - It is a common Ruby idiom to put a ! at the end of the names of methods
#     that mutate their callers.
#   - ! is also used in the != operator.
#
# ? also has a few uses in Ruby.
#   - It is the ternary operator, which is used like this:
test_boolean = true
puts test_boolean ? 'logic is still working' : 'uh oh'
#     If test_boolean evaluates to a true value, the value
#     of this expression will be the expression following the ?
#     if test_boolean evaluates to a false value, the value
#     of this expression will be the expression following the : 
#   - It is a common Ruby idiom to put a ? at the end of the names of methods
#     that return a true or false value.
#
# != is the 'not equals' operator. It can be applied to two operands and
# will return true if the two operands are not equal, false otherwise.
# The != is the opposite of the == operator, which tests whether two operands
# are equal. By default, Ruby considers two values "equal" if they have the
# same hash code. This is not the case for all Ruby objects as the #eql?
# method (== is synonymous with this method) is often overriden by subclasses.

user_name = 'jleath'
puts !user_name        # -> will print false

# This method mutates the caller by removing the first item in the array
def delete_first!(arr)
  arr.delete_at(0)
end

# QUESTION 3
# ----------------------------------------------------------------------------
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!('important', 'urgent')
puts advice


# QUESTION 4
# ----------------------------------------------------------------------------
numbers = [3, 2, 1, 4]
# This will delete and return the item at index 1, if there are less than 1 values
# in the array, it will just return nil
numbers.delete_at(1)
# This will delete the first occurence of the value 1 in the array, if no such value
# exists it will just return nil
numbers.delete(1)

# QUESTION 5
# ----------------------------------------------------------------------------
(10..100).include?(42)
(10..100).cover?(42)

# QUESTION 6
# ----------------------------------------------------------------------------
famous_words = "seven years ago..."
# does not mutate famous_words
puts "Four score and " + famous_words
puts "Four score and ".concat(famous_words)
puts "Four score and " << famous_words
# does mutate famous_words
famous_words.prepend('Four score and ')
puts famous_words

# QUESTION 7
# ----------------------------------------------------------------------------
flintstones = ['Fred', 'Wilma']
flintstones << ['Barney', 'Betty']
flintstones << ['BamBam', 'Pebbles']
p flintstones
p flintstones.flatten!

# QUESTION 8
# ----------------------------------------------------------------------------
flintstones = { 'Fred' => 0, 'Wilma' => 1, 'Barney' => 2, 'BamBam' => 4, 'Pebbles' => 5 }
p barney = flintstones.assoc('Barney')