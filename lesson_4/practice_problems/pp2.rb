def sum_values(hash)
  hash.values.reduce(:+)
end

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
puts sum_values(ages) == 6174