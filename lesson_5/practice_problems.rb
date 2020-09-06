# Problem 1
arr = ['10', '11', '9', '7', '8']
# sort by descending numeric value
p arr.sort { |a, b| b.to_i <=> a.to_i }

# Problem 2
books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]
# order based on the year of publication, earliest to latest
p (books.sort_by do |book|
  book[:published].to_i
end)

# Problem 3
arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
puts arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
puts arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
puts arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
puts hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
puts hsh2[:third].key(0)

# Problem 4
arr1 = [1, [2, 3], 4]
arr1[1][1] = 4
p arr1

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4
p arr2

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4
p hsh1

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4
p hsh2

# Problem 5
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# Get total age of just the males in the family
p munsters.map { |_, value| value['gender'] == 'male' ? value['age'] : 0 }.reduce(:+)

# Problem 6
# Print out the name, age, and gender of each family member
munsters.each do |key, value|
  puts "#{key} is a #{value['age']}-year-old #{value['gender']}."
end

# Problem 7
a = 2
b = [5, 8]
arr = [a, b]
arr[0] += 2
arr[1][0] -= a

puts a # will be 2
p b    # will be [3, 8]

# Problem 8
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# output all the vowels from the strings in hsh
vowels = ''
hsh.values.each do |arr|
  arr.each do |str|
    str.each_char do |c|
      vowels << c if c =~ /[aeiou]/i
    end
  end
end
puts vowels

# Problem 9
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
# Return a new array of the same structure but with subarrays sorted in descending order
p arr.map { |subarray| subarray.sort { |a, b| b <=> a } }

# Problem 10
test = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]
# Use the map method to return a new array idential in structure but where each value is
# incremented by 1
p test.map { |hash| hash.map { |key, value| [key, value + 1] }.to_h }


# Problem 11
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]
# Use a combination of methods, including either select or reject to return a new array
# identical in structure but containing only integers that are multiples of 3
p (arr.map do |subarr|
  subarr.select do |item|
    item % 3 == 0
  end
end)

# Problem 12
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# Without using the to_h method, return a hash where the key is the first item in each
# sub array and the value is the second item
new_hash = {}
arr.each do |subarr|
  new_hash[subarr[0]] = subarr[1]
end
p new_hash

# Problem 13
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
# Return a new array containing the same sub-arrays but ordered logically by only taking
# into consideration the odd numbers they contain
p arr.sort_by { |subarr| subarr.select { |x| x.odd? } }

# Problem 14
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}
# return an array containing the colors of the fruits and the sizes of the vegetabls.
# sizes should be uppercase and the colors capitalized
p (hsh.map do |_, value|
  if value[:type] == 'fruit'
    value[:colors].map { |color| color.capitalize }
  else
    value[:size].upcase
  end
end)

# Problem 15
arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]
# return an array which contains only the hashes where all the integers are even
p (arr.select do |hash|
  hash.values.all? do |values_array|
    values_array.all? { |x| x.even? }
  end
end)

def build_uuid
  possible_chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
  values = []
  32.times { values << possible_chars[rand(possible_chars.size)] }
  values = values.join
  "#{values[0,8]}-#{values[8,4]}-#{values[12,4]}-#{values[16,4]}-#{values[20,12]}"
end

puts build_uuid
puts build_uuid