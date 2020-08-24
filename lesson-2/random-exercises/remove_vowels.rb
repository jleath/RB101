# Write a method that takes an array of strings, and returns an array of the
# same string values, except with the vowels removed.


def strip_vowels(word)
  vowels = %w(a e i o u A e i o u)
  stripped = word.split('').select { |c| !vowels.include?(c) }
  stripped.join
end

def remove_vowels(words)
  words.map { |word| strip_vowels(word) }
end

# output => ['grn', 'yllw', 'blck', 'wht']
p remove_vowels(['green', 'yellow', 'black', 'white'])

