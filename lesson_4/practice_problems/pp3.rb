ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# using Hash#reject
less_than_100 = ages.reject { |name, age| age >= 100 }
puts less_than_100 == { 'Herman' => 32, 'Lily' => 30, 'Eddie' => 10 }

#iterative solution
less_than_100 = {}
ages.keys.each do |name|
  age = ages[name]
  less_than_100[name] = age if age < 100
end
puts less_than_100 == { "Herman" => 32, "Lily" => 30, "Eddie" => 10 }

ages.keep_if { |_, age| age < 100 }
puts ages == { "Herman" => 32, "Lily" => 30, "Eddie" => 10 }

