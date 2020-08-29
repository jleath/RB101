# QUESTION 1
# ----------------------------------------------------------------------------
# nothing will happen, the line assigning hello world to greeting may never be
# executed, but ruby initializes greeting to nil anyway
if false
  greeting = "hello world"
end

greeting

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting # => 'hi there'
puts greetings # => {:a=>'hi there'}

# A)
def mess_with_varsA(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_varsA(one, two, three)

puts "one is: #{one}" # one is one
puts "two is: #{two}" # two is two
puts "three is: #{three}" # three is three

# B)
def mess_with_varsB(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_varsB(one, two, three)

puts "one is: #{one}" # one is one
puts "two is: #{two}" # two is two
puts "three is: #{three}" # three is three

# C)
def mess_with_varsC(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_varsC(one, two, three)

puts "one is: #{one}" # one is two
puts "two is: #{two}" # two is three
puts "three is: #{three}" # three is one

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split('.')
  return false if dot_separated_words.size != 4

  dot_separated_words.each do |word|
    return false if !is_an_ip_number?(word)
  end
  true