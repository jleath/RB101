require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

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
  # only looks at the first character of the input
  valid_fn = ->(input) { %w[y n Y N].include?(input.chr) }
  get_input(message, valid_fn).chr.downcase
end

def get_positive_int(message)
  valid_fn = ->(input) { /^\d+$/.match(input) }
  result = nil
  loop do
    result = get_input(message, valid_fn).to_i
    break if result.positive?

    prompt 'non_positive_input'
  end
  result
end

def get_positive_float(message)
  valid_fn = ->(input) { /^\d?.?\d+$/.match(input) }
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

prompt 'welcome'

loop do
  loan_amount = get_positive_float 'enter_loan_amount'
  annual_rate = get_percentage 'enter_apr'
  monthly_rate = annual_rate / 12.0
  loan_years = get_positive_int 'enter_duration'
  loan_months = loan_years * 12
  monthly_payment = calculate_rate(loan_amount, monthly_rate, loan_months)

  prompt 'monthly_rate_output', format('%.2f%%', monthly_rate * 100)
  prompt 'duration_output', loan_months.to_s
  prompt 'payment_output', monthly_payment.round(2).to_s
  puts ''

  break if get_yes_no('run_again') != 'y'
end

prompt 'goodbye'
