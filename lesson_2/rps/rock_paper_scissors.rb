require 'yaml'
RPS_MESSAGES = YAML.load_file('rock_paper_scissors_messages.yml')

SLEEP_TIME = 0.75
VALID_SHAPES = %w[rock paper scissors]
VALID_YES_NO = %w[yes no]

WIN_CONDITIONS = {
  rock: %w[scissors],
  paper: %w[rock],
  scissors: %w[paper]
}

def prompt(message, postfix='', lang='en')
  prompt_msg = RPS_MESSAGES[lang]['prompt']
  puts "#{prompt_msg} #{RPS_MESSAGES[lang][message]} #{postfix}"
end

def valid_selection?(choice)
  VALID_SHAPES.include?(choice)
end

def get_input(message, valid_fn, postfix='')
  loop do
    prompt message, postfix
    input = gets.chomp
    return input if valid_fn.call(input)
    prompt 'invalid_choice_msg'
  end
end

def get_player_choice
  valid_fn = ->(choice) { VALID_SHAPES.include?(choice) }
  get_input('choose_shape_msg', valid_fn, VALID_SHAPES.join(', '))
end

def print_computer_choice_sequence
  print RPS_MESSAGES['en']['prompt'] + ' '
  print RPS_MESSAGES['en']['computer_thinking_msg']
  3.times do
    sleep(SLEEP_TIME)
    print '.'
  end
  sleep(SLEEP_TIME)
  puts ''
end

def get_computer_choice
  print_computer_choice_sequence
  choice = VALID_SHAPES.sample
  prompt 'computer_chose_msg', choice
  choice
end

def win?(first, second)
  WIN_CONDITIONS[first.to_sym].include? second
end

def display_results(player, computer)
  if win?(player, computer)
    prompt 'player_won_msg'
  elsif win?(computer, player)
    prompt 'computer_won_msg'
  else
    prompt 'tie_msg'
  end
end

def play_again?
  valid_fn = ->(input) { VALID_YES_NO.include?(input.downcase) }
  answer = get_input('play_again_msg', valid_fn)
  answer.downcase == 'yes'
end

def display_choices(player_choice, computer_choice)
  prompt 'computer_chose_msg', computer_choice
  prompt 'player_chose_msg', player_choice
end

loop do
  player_choice = get_player_choice
  computer_choice = get_computer_choice
  display_results(player_choice, computer_choice)
  break unless play_again?
end

prompt 'goodbye_msg'
