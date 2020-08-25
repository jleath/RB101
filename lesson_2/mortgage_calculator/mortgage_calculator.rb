require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

VALID_YES_NO_RESPONSES = %w[y yes n no]
VALID_YES_RESPONSES = %w[y yes]
POS_INT_REGEX = /^\d+$/
POS_FLOAT_REGEX = /^\d?.?\d+$/
MONTHS_IN_YEAR = 12

def clear_screen
  system('clear') || system('cls')
end

def prompt(message, postfix='', lang='en')
  puts ">> #{MESSAGES[lang][message]}#{postfix}"
end

def calculate_rate(loan_amount, monthly_rate, loan_months)
  loan_amount * (monthly_rate / (1 - (1 + monthly_rate)**-loan_months))
end

def get_input(message, valid_fn)
  input = ''
  loop do
    prompt message
    input = gets.chomp
    break if valid_fn.call(input)

    prompt 'invalid_input'
  end
  input
end

def get_yes_no(message)
  valid_fn = ->(input) { VALID_YES_NO_RESPONSES.include?(input.downcase) }
  get_input(message, valid_fn)
end

def get_positive_int(message)
  valid_fn = ->(input) { POS_INT_REGEX.match(input) }
  result = nil
  loop do
    result = get_input(message, valid_fn).to_i
    break if result.positive?

    prompt 'non_positive_input'
  end
  result
end

def get_positive_float(message)
  valid_fn = ->(input) { POS_FLOAT_REGEX.match(input) }
  result = nil
  loop do
    result = get_input(message, valid_fn).to_f
    break if result.positive?

    prompt 'non_positive_input'
  end
  result
end

def get_percentage(message)
  get_positive_float(message) / 100.0
end

def another_calculation?
  VALID_YES_RESPONSES.include?(get_yes_no('run_again').downcase)
end

def display_monthly_rate(monthly_rate)
  prompt 'monthly_rate_output', format('%.2f%%', monthly_rate * 100.0)
end

def display_duration(loan_months)
  prompt 'duration_output', loan_months.to_s
end

def display_payment(monthly_payment)
  prompt 'payment_output', format('%.2f', monthly_payment)
end

clear_screen

prompt 'welcome'

loop do
  loan_amount = get_positive_float 'enter_loan_amount'
  annual_rate = get_percentage 'enter_apr'
  loan_years = get_positive_int 'enter_duration'

  monthly_rate = annual_rate / MONTHS_IN_YEAR
  loan_months = loan_years * MONTHS_IN_YEAR
  monthly_payment = calculate_rate(loan_amount, monthly_rate, loan_months)

  display_monthly_rate monthly_rate
  display_duration loan_months
  display_payment monthly_payment

  break if !another_calculation?
end

prompt 'goodbye'
