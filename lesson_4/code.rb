produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(produce)
  keys = produce.keys
  i = 0
  result = {}
  while i < keys.size
    if produce[keys[i]] == 'Fruit'
      result[keys[i]] = 'Fruit' 
    end
    i += 1
  end
  result
end

puts select_fruit(produce)

def double_numbers!(numbers)
  i = 0
  loop do
    break if i >= numbers.size
    
    numbers[i] *= 2
    i += 1
  end
  numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
double_numbers!(my_numbers)
p my_numbers

def double_odd_indices(numbers)
  result = []
  counter = 0
  loop do
    break if counter == numbers.size

    current_value = numbers[counter]
    if counter.odd?
      result << current_value * 2
    else
      result << current_value  
    end
    counter += 1
  end
  result
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_odd_indices(my_numbers)
p my_numbers

def multiply(numbers, multiplier)
  result = []
  counter = 0
  loop do
    break if counter == numbers.size

    curr_value = numbers[counter] * multiplier
    result << curr_value 
    counter += 1
  end
  result
end

p multiply(my_numbers, 3)