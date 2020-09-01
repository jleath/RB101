# given an array, return a hash with the items of the array as keys and the
# index of each item as the value.

# an empty array should return an empty hash
# the first item in the array has index 0

def build_hash(arr)
  result = {}
  i = 0
  loop do
    break if i == arr.size

    result[arr[i]] = i
    i += 1
  end
  result
end

def build_hash(arr)
  result = {}
  arr.each_index { |i| result[arr[i]] = i }
  result
end

# kind of a silly way to do this
def build_hash(arr)
  result = Hash.new { |result, index| result[arr[index]] = index}
  arr.each_index { |i| result[i] }
  result
end

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
expected_hash = {
  'Fred' => 0,
  'Barney' => 1,
  'Wilma' => 2,
  'Betty' => 3,
  'Pebbles' => 4,
  'BamBam' => 5
}
flintstones_hash = build_hash(flintstones)
puts flintstones_hash == expected_hash