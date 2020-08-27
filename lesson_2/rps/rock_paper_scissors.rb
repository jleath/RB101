require 'yaml'
RPS_MESSAGES = YAML.load_file('rock_paper_scissors_messages.yml')

LANG = :en
SLEEP_TIME = 0.75
NUM_MATCHES_TO_WIN = 5
VALID_SHAPES = %w[rock paper scissors spock lizard]
PLAYER_SCORE_INDEX = 0
COMPUTER_SCORE_INDEX = 1

def string_lookup(*args)
  message = RPS_MESSAGES[LANG]
  args.size.times { |n| message = message[args[n]] }
  message
end

def display(output_msg, newline=true)
  prompt_msg = string_lookup(:prompt)
  if output_msg.is_a? Symbol
    output_msg = string_lookup(output_msg)
  end
  print "#{prompt_msg} #{output_msg}"
  puts '' if newline
end

def valid_selection?(choice)
  VALID_SHAPES.include?(choice)
end

def get_input(message, valid_fn)
  loop do
    display message
    input = gets.chomp
    return input if valid_fn.call(input)
    display :invalid_choice_msg
  end
end

def get_player_choice
  valid_fn = ->(choice) { VALID_SHAPES.include?(choice) }
  valid_input_msg = VALID_SHAPES.join(', ')
  input_prompt = "#{string_lookup(:choose_shape_msg)} #{valid_input_msg}"
  get_input(input_prompt, valid_fn)
end

def get_computer_choice
  display :computer_thinking_msg
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
  string_lookup(:win_messages, first.to_sym, second.to_sym)
end

def display_win_message(shape1, shape2, winner)
  if winner == :player_won
    display string_lookup(:win_messages, shape1.to_sym, shape2.to_sym)
    display :player_won_msg
  elsif winner == :computer_won
    display string_lookup(:win_messages, shape2.to_sym, shape1.to_sym)
    display :computer_won_msg
  else
    display :tie_msg
  end
  sleep(SLEEP_TIME)
end

def determine_winner(player, computer)
  winner = :tied_game
  if win?(player, computer)
    winner = :player_won
  elsif win?(computer, player)
    winner = :computer_won
  end
  winner
end

def display_choices(player, computer)
  # add a newline to space out the output
  puts('')
  display "#{string_lookup(:player_chose_msg)} #{player}"
  sleep(SLEEP_TIME)
  display "#{string_lookup(:computer_chose_msg)} #{computer}"
  sleep(SLEEP_TIME)
end

def display_results(player, computer, winner)
  display_choices(player, computer)
  display_win_message(player, computer, winner)
end

def user_forfeit?
  valid_fn = ->(input) { %w[yes no].include?(input.downcase) }
  answer = get_input(:play_again_msg, valid_fn)
  answer.downcase == 'yes'
end

def play_game
  player_choice = get_player_choice
  computer_choice = get_computer_choice
  winner = determine_winner(player_choice, computer_choice)
  display_results(player_choice, computer_choice, winner)
  winner
end

def game_over?(scores)
  if scores[PLAYER_SCORE_INDEX] == NUM_MATCHES_TO_WIN
    :player_won
  elsif scores[COMPUTER_SCORE_INDEX] == NUM_MATCHES_TO_WIN
    :computer_won
  else
    :game_not_complete
  end
end

def update_scores(scores, winner)
  if winner == :player_won
    scores[PLAYER_SCORE_INDEX] += 1
  elsif winner == :computer_won
    scores[COMPUTER_SCORE_INDEX] += 1
  end
end

def display_winner(grand_winner)
  if grand_winner == :player_won
    display :player_grand_winner_msg
  else
    display :computer_grand_winner_msg
  end
end

# -- Main game loop
display :welcome
display format(string_lookup(:num_matches_msg), num_matches: NUM_MATCHES_TO_WIN)

scores = [0, 0]

loop do
  winner = play_game
  update_scores(scores, winner)
  grand_winner = game_over?(scores)
  if grand_winner != :game_not_complete
    display_winner(grand_winner)
    break
  elsif user_forfeit?
    display_winner(:computer_won)
    break
  end
end

display :goodbye_msg
