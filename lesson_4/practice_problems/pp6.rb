flintstones = %w[Fred Barney Wilma Betty BamBam Pebbles]
expected_output = %w[Fre Bar Wil Bet Bam Peb]
max_char = 3

puts flintstones.map { |name| name.slice(0, max_char) } == expected_output

result = []
flintstones.each { |name| result << name[0, max_char] }
puts result == expected_output