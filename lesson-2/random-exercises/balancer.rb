# Write a method that takes a string, and returns a boolean indicating whether
# this string has a balanced set of parentheses.

def balancer(text)
  counts = text.split('')
  num_parens = 0
  counts.each do |c|
    if c == '('
      num_parens += 1
    elsif c == ')'
      return false if num_parens == 0
      num_parens -= 1
    end
  end
  num_parens == 0
end

puts balancer("") # => true
puts balancer("(lots(of(parens)much)bigger)") # => true
puts balancer("((this) is (bad)")
puts balancer("hi") # => true
puts balancer("(hi") # => false
puts balancer("(hi)") # => true
puts balancer(")hi(") # => false

