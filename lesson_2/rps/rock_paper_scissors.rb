require 'yaml'
RPS_MESSAGES = YAML.load_file('rock_paper_scissors_messages.yml')
LANG = 'en'
SLEEP_TIME = 0.75
VALID_SHAPES = %w[rock paper scissors spock lizard]
VALID_YES_NO = %w[yes no]

WIN_CONDITIONS = {
  rock: %w[lizard scissors],
  paper: %w[rock spock],
  scissors: %w[paper lizard],
  lizard: %w[spock paper],
  spock: %w[scissors rock]
}

def get_message(*args)
  message = RPS_MESSAGES[LANG]
  args.size.times { |n| message = message[args[n]] }
  message
end

def prompt(output_msg, postfix='', newline=true)
  prompt_msg = get_message('prompt')
  print "#{prompt_msg} #{get_message(output_msg)}#{postfix}"
  puts '' if newline
end

def valid_selection?(choice)
  VALID_SHAPES.include?(choice)
end

def get_input(message, valid_fn, msg_postfix='')
  loop do
    prompt message, ' ' + msg_postfix
    input = gets.chomp
    return input if valid_fn.call(input)
    prompt 'invalid_choice_msg'
  end
end

def get_player_choice
  valid_fn = ->(choice) { VALID_SHAPES.include?(choice) }
  valid_input_msg = VALID_SHAPES.join(', ')
  get_input('choose_shape_msg', valid_fn, valid_input_msg)
end

def get_computer_choice
  prompt 'computer_thinking_msg'
  print '   '
  3.times do
    sleep SLEEP_TIME
    print '.'
  end
  sleep SLEEP_TIME
  puts ''
  VALID_SHAPES.sample
end

def win?(first, second)
  WIN_CONDITIONS[first.to_sym].include? second
end

def display_win_message(winning_shape, losing_shape, winner)
  prompt '', get_message('win_messages', winning_shape, losing_shape)
  sleep(SLEEP_TIME)
  prompt "#{winner}_won_msg"
end

def display_results(player, computer)
  # add a newline to space out the output
  puts('')
  prompt 'player_chose_msg', ' ' + player
  sleep(SLEEP_TIME)
  prompt 'computer_chose_msg', ' ' + computer
  sleep(SLEEP_TIME)
  if win?(player, computer)
    display_win_message(player, computer, 'player')
  elsif win?(computer, player)
    display_win_message(computer, player, 'computer')
  else
    sleep(SLEEP_TIME)
    prompt 'tie_msg'
  end
end

def play_again?
  valid_fn = ->(input) { VALID_YES_NO.include?(input.downcase) }
  answer = get_input('play_again_msg', valid_fn)
  answer.downcase == 'yes'
end

def play_game
  player_choice = get_player_choice
  computer_choice = get_computer_choice
  display_results(player_choice, computer_choice)
end

prompt 'welcome'
loop do
  play_game
  break unless play_again?
end
prompt 'goodbye_msg'
