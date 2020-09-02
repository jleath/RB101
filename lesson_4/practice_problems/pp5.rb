flintstones = %w[Fred Barney Wilma Betty BamBam Pebbles]

def prefix?(str, prefix)
  return false if str.length < prefix.length

  i = 0
  loop do
    break if i == prefix.length

    return false unless str[i] == prefix[i]

    i += 1
  end
  true
end

def find_first_with_prefix(arr, prefix)
  arr.each_with_index do |name, index|
    return index if prefix?(name, prefix)

  end
  nil
end

prefix = 'Be'

# plain old iterative solution
puts find_first_with_prefix(flintstones, prefix) == 3

# select using prefix method
puts flintstones.index{ |name| prefix?(name, prefix) } == 3

# select with Regexp
puts flintstones.index{ |name| name.match(/^#{prefix}.*$/) } == 3

# slicing
puts flintstones.index { |name| name[0, prefix.length] == prefix } == 3