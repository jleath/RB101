# modify the munsters hash so that each member of the Munster family has an additional
# 'age_group' key that describes the age group of the member.

# kid: 0-17
# adult: 18-64
# senior: 65+

# each value of the hash is a nested hash
# iterate through the values of the munsters hash
# get the age value for each hash
# determine the age group for each hash
# add an additional key called 'age_group' and associate it with the correct age group

MAX_CHILD_AGE = 17
MAX_ADULT_AGE = 64

def get_age_group(age)
  case age
  when 0..MAX_CHILD_AGE then 'kid'
  when MAX_CHILD_AGE+1..MAX_ADULT_AGE then 'adult'
  else 'senior'
  end
end

def add_age_groups(hash)
  hash.values.each do |member|
    age_group = get_age_group(member['age'])
    member['age_group'] = age_group
  end
end

munsters = {
  'Herman' => { 'age' => 32, 'gender' => 'male' },
  'Lily' => { 'age' => 30, 'gender' => 'female' },
  'Grandpa' => { 'age' => 402, 'gender' => 'male' },
  'Eddie' => { 'age' => 10, 'gender' => 'male' },
  'Marilyn' => {'age' => 23, 'gender' => 'female'}
}

expected = {
  'Herman' => { 'age' => 32, 'gender' => 'male', 'age_group' => 'adult' },
  'Lily' => { 'age' => 30, 'gender' => 'female', 'age_group' => 'adult' },
  'Grandpa' => { 'age' => 402, 'gender' => 'male', 'age_group' => 'senior' },
  'Eddie' => { 'age' => 10, 'gender' => 'male', 'age_group' => 'kid' },
  'Marilyn' => {'age' => 23, 'gender' => 'female', 'age_group' => 'adult'}
}

add_age_groups(munsters)
puts munsters == expected