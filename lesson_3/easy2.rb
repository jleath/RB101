# QUESTION 1
# ----------------------------------------------------------------------------
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.keys.include?('Spot')
ages.has_key?('Spot')
ages.member?('Spot')

# QUESTION 2
# ----------------------------------------------------------------------------
munsters_description = 'The Munsters are creepy in a good way.'

puts munsters_description.swapcase
puts munsters_description.capitalize
puts munsters_description.downcase
puts munsters_description.upcase

# QUESTION 3
# ----------------------------------------------------------------------------
ages["Grandpa"] = 5843
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)
p ages

# QUESTION 4
# ----------------------------------------------------------------------------
advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.include?("Dino")
puts advice.match?("Dino")

# QUESTION 5
# ----------------------------------------------------------------------------
flintstones = %w[Fred Barney Wilma Betty BamBam Pebbles]

# QUESTION 6
# ----------------------------------------------------------------------------
flintstones.push("Dino")

# QUESTION 7
# ----------------------------------------------------------------------------
flintstones.pop
p flintstones
# Could also use concat
# #push also returns the array so you could chain
flintstones = flintstones.union(["Dino", "Hoppy"])
p flintstones

# QUESTION 8
# ----------------------------------------------------------------------------
puts advice.slice(0, advice.index("house"))
p advice

# QUESTION 9
# ----------------------------------------------------------------------------
statement = "The Flintstones Rock!"
puts statement.count("t")

# QUESTION 10
# ----------------------------------------------------------------------------
title = "Flintstone Family Members"
puts title.center(40)