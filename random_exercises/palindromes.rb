# Given a string, write a function that returns an array containing
# all palindromes in that string of two or more characters in length.

def palindrome?(word)
  word.size >= 2 && word.reverse == word
end

# a method that doesn't use the #reverse method.
def palindrome?(word)
  return false if word.size < 2

  start = 0
  stop = word.size - 1
  loop do
    return false if word[start] != word[stop]

    return true if start == stop

    start += 1
    stop -= 1
  end
end

def get_palindromes(words)
  words.select { |word| manual_is_palindrome word }
end

# [bob, abcdefedcba]
p get_palindromes(%w[yup bob abcdefedcba nope yellowstone])

# []
p get_palindromes([])
