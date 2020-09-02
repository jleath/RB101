statement = 'The Flintstones Rock'

def letter_frequencies(str)
  letter_counts = Hash.new(0)
  str.each_char do |c|
    letter_counts[c] += 1 if c.count('a-zA-Z') > 0
  end
  letter_counts
end

result = {"T"=>1, "h"=>1, "e"=>2, "F"=>1, "l"=>1, "i"=>1, "n"=>2, "t"=>2, "s"=>2, "o"=>2, "R"=>1, "c"=>1, "k"=>1}

puts letter_frequencies(statement) == result