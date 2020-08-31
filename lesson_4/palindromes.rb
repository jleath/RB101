def get_substrings(text)
  substrings = []
  substring_size = 2
  while substring_size <= text.size
    substrings.append(text.slice(0, substring_size))
    substring_size += 1
  end
  substrings
end

def get_all_substrings(text)
  curr_char = 0
  substrings = []
  while text.size >= 2
    substrings.concat(get_substrings(text))
    text = text.slice(1, text.size-1)
  end
  substrings
end

def palindrome?(word)
  word == word.reverse
end

def get_all_palindromes(text)
  substrings = get_all_substrings(text)
  substrings.select { |word| palindrome?(word) }
end

puts get_all_palindromes('supercalifragilisticexpialidocious') == ['ili']
puts get_all_palindromes('abcddcbA') == ['bcddcb', 'cddc', 'dd']
puts get_all_palindromes('palindrome') == []
puts get_all_palindromes('') == []