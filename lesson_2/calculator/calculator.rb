require 'yaml'

MESSAGES = YAML.load_file("calculator_messages.yml")

def prompt(message, alt='', lang='en')
  puts "#{MESSAGES[lang]['prompt']} #{MESSAGES[lang][message]} #{alt}"
end

def valid_number?(num)
  Integer(num) rescue false
  Float(num) rescue false
end

def operation_to_message(op)
  message = case op
            when '1' then "add_msg"
            when '2' then "subtract_msg"
            when '3' then "multiply_msg"
            when '4' then "divide_msg"
            end
  message
end

prompt "welcome"

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt "valid_name"
  else
    break
  end
end

prompt "greeting", name

loop do
  number1 = ''

  loop do
    prompt "input_first_number"
    number1 = gets.chomp
    if valid_number? number1
      break
    else
      prompt "invalid_number"
    end
  end

  number2 = ''

  loop do
    prompt "input_second_number"
    number2 = gets.chomp
    if valid_number? number2
      break
    else
      prompt "invalid_number"
    end
  end

  prompt "operator_prompt"

  operator = ''

  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include? operator
      break
    else
      prompt "invalid_operator"
    end
  end

  prompt operation_to_message operator

  result = case operator
           when '1' then number1.to_f + number2.to_f
           when '2' then number1.to_f - number2.to_f
           when '3' then number1.to_f * number2.to_f
           when '4' then number1.to_f / number2.to_f
           end

  prompt "result", result
  prompt "run_again"
  answer = gets.chomp
  break unless answer.downcase == 'y'
end

prompt "goodbye"
