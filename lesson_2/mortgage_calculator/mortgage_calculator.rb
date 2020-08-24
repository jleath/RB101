def prompt(message)
  puts ">> #{message}" 
end

def calculate_monthly_rate(loan_amount, monthly_rate, loan_duration_months)
  if monthly_rate == 0.0
    loan_amount / loan_duration_months
  else
    loan_amount * (monthly_rate / (1 - (1 + monthly_rate)**(-loan_duration_months)))
  end
end

def get_input(message, valid_fn)
  input = ''
  loop do
    prompt message
    input = gets.chomp
    break if valid_fn.call(input)
    prompt "Sorry, there is something wrong with your answer. Please try again."
  end
  input
end

def get_yes_no(message)
  valid_fn = lambda { |input| %w(y n Y N).include?(input) }
  get_input(message, valid_fn).downcase
end

def get_positive_int(message)
  valid_fn = lambda { |input| /^\d+$/.match(input) }
  result = get_input(message, valid_fn).to_i
end

def get_float(message)
  valid_fn = lambda { |input| /^\d?.?\d+$/.match(input) }
  get_input(message, valid_fn).to_f
end

def get_percentage(message)
  get_float(message) / 100.0
end

prompt "Welcome to the Mortgage Calculator!"

loop do
  loan_amount = get_float "Enter the amount of your loan in dollars (ex. 1234.34):"
  annual_rate = get_percentage "Enter the annual percentage rate of the loan (ex. 5.0):"
  monthly_rate = annual_rate / 12.0
  loan_duration_years = get_int "Enter the loan duration in years (ex 5):"
  loan_duration_months = loan_duration_years * 12
  monthly_payment = calculate_monthly_rate(loan_amount, monthly_rate, loan_duration_months)

  prompt "Monthly Interest Rate: #{(monthly_rate * 100).round(2)}%"
  prompt "Loan Duration (Months): #{loan_duration_months}"
  prompt "Monthly Payment: $#{monthly_payment.round(2)}"
  puts ""

  break if get_yes_no("Would you like to run the Mortgage Calculator again?") == 'n'
end

prompt "Thank you for using the Mortgage Calculator!"