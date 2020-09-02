words = 'the flintstones rock'

def titleize(str)
  str.split(' ').map { |word| word.capitalize }.join(' ')
end

expected = 'The Flintstones Rock'
result = titleize(words)
puts result == expected
