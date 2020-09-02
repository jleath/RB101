ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
puts ages.min[1] == 10
puts ages.values.min == 10

names = ages.keys
i = 0
youngest_age = nil
loop do
  break if i == names.size

  name = names[i]
  age = ages[name]
  if youngest_age == nil || age < youngest_age
    youngest_age = age
  end
  i += 1
end
puts youngest_age == 10