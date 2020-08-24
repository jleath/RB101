# Write a method that takes two numbers. It should print out all primes between
# the two numbers. Don't use Ruby's 'prime' class.

def is_prime(n)
  return false if n <= 1
  i = 2
  max = Math.sqrt(n)
  loop do 
    return false if n % i == 0
    return true if i > max
    i += 1  
  end
end

def find_primes(start, stop)
  (start..stop).each do |i|
    puts i if is_prime(i)
  end
end

find_primes(3, 10) # => 3, 5, 7