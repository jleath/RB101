require 'yaml'
RPS_MESSAGES = YAML.load_file('rock_paper_scissors_messages.yml')

LANG = :en
SLEEP_TIME = 0.75
NUM_MATCHES_TO_WIN = 5
VALID_SHAPES = {
  'rock' => %w[r rock],
  'paper' => %w[p paper],
  'scissors' => %w[sc scissors],
  'spock' => %w[sp spock],
  'lizard' => %w[l lizard]
}
MAXIMUM_MOCKS = 3

def clear_screen
  system('clear') | system('cls')
end

def string_lookup(*args)
  message = RPS_MESSAGES[LANG]
  args.size.times { |n| message = message[args[n]] }
  message
end

def display(output_msg, newline=true)
  prompt_msg = string_lookup(:prompt)
  if output_msg.is_a?(Symbol)
    output_msg = string_lookup(output_msg)
  end
  print "#{prompt_msg} #{output_msg}"
  puts '' if newline
end

def get_input(message, valid_fn)
  loop do
    display(message)
    input = gets.chomp
    result = valid_fn.call(input)
    return result.downcase if !valid_fn.nil?

    display(:invalid_choice_msg)
  end
end

def lookup_shape_key(shape_input)
  VALID_SHAPES.each do |shape, valid_inputs|
    return shape if valid_inputs.include?(shape_input.downcase)
  end
  nil
end

def get_player_choice
  valid_fn = ->(choice) { lookup_shape_key(choice) }
  valid_input_msg = VALID_SHAPES.keys.join(', ')
  input_prompt = "#{string_lookup(:choose_shape_msg)} #{valid_input_msg}"
  get_input(input_prompt, valid_fn)
end

def get_computer_choice
  display(:computer_thinking_msg)
  print '   '
  3.times do
    sleep(SLEEP_TIME)
    print '.'
  end
  sleep(SLEEP_TIME)
  puts ''
  VALID_SHAPES.keys.sample
end

def win?(first, second)
  string_lookup(:win_messages, first.to_sym, second.to_sym) != nil
end

def determine_winner(player, computer)
  winner = :tied_game
  if win?(player, computer)
    winner = :player
  elsif win?(computer, player)
    winner = :computer
  end
  winner
end

def display_win_message(shape1, shape2, winner)
  if winner == :player
    display string_lookup(:win_messages, shape1.to_sym, shape2.to_sym)
    display(:player_won_msg)
  elsif winner == :computer
    display string_lookup(:win_messages, shape2.to_sym, shape1.to_sym)
    display(:computer_won_msg)
  else
    display(:tie_msg)
  end
  sleep(SLEEP_TIME)
end

def display_choices(player, computer)
  puts ''
  display("#{string_lookup(:player_chose_msg)} #{player}")
  sleep(SLEEP_TIME)
  display("#{string_lookup(:computer_chose_msg)} #{computer}")
  sleep(SLEEP_TIME)
end

def display_results(player, computer, winner)
  display_choices(player, computer)
  display_win_message(player, computer, winner)
end

def display_winner(grand_winner)
  if grand_winner == :player
    display(:player_grand_winner_msg)
  else
    display(:computer_grand_winner_msg)
  end
end

def get_yes_no(message)
  valid_fn = lambda do |input|
    if %w[yes no].include?(input.downcase)
      return input
    else
      return nil
    end
  end
  get_input(message, valid_fn)
end

def user_forfeit?
  get_yes_no(:play_again_msg) == 'yes'
end

def user_ready?(mock_user=false, num_times_mocked=0)
  mocking_messages = [:mock_msg1, :mock_msg2, :mock_msg3, :mock_msg4]
  message = mock_user ? mocking_messages[num_times_mocked] : :player_ready_msg
  if num_times_mocked == MAXIMUM_MOCKS
    display(message)
    sleep(SLEEP_TIME * 2)
    true
  else
    get_yes_no(message) == 'yes'
  end
end

def play_round
  player_choice = get_player_choice
  computer_choice = get_computer_choice
  winner = determine_winner(player_choice, computer_choice)
  display_results(player_choice, computer_choice, winner)
  winner
end

def game_over?(scores)
  scores.each do |_, score|
    return true if score == NUM_MATCHES_TO_WIN
  end
  false
end

def get_winner(scores)
  scores.each do |player, score|
    return player if score == NUM_MATCHES_TO_WIN
  end
end

def display_scores(scores)
  player_score = scores[:player]
  computer_score = scores[:computer]
  winner_indicator = string_lookup(:tie_symbol)
  if player_score > computer_score
    winner_indicator = string_lookup(:player_winning_symbol)
  elsif computer_score > player_score
    winner_indicator = string_lookup(:computer_winning_symbol)
  end
  display(:scoreboard_header)
  display("  #{player_score}    #{winner_indicator}    #{computer_score}")
end

def update_scores(scores, winner)
  return if winner == :tied_game

  scores[winner] += 1
end

def move_to_next_round?(round_winner)
  if round_winner == :computer && user_forfeit?
    return false
  elsif round_winner != :computer && !user_ready?
    mocks = 0
    loop do
      break if user_ready?(true, mocks)
      mocks += 1
    end
  end
  true
end

clear_screen
display(:welcome)
display(format(string_lookup(:num_matches_msg),
               num_matches: NUM_MATCHES_TO_WIN))

scores = { player: 0, computer: 0 }

# -- Main game Loop --
game_winner = nil

loop do
  round_winner = play_round
  update_scores(scores, round_winner)
  if game_over?(scores)
    game_winner = get_winner(scores)
    break
  end
  if !move_to_next_round?(round_winner)
    game_winner = :computer
    break
  end
  clear_screen
  display_scores(scores)
end

display_winner(game_winner)
display(:goodbye_msg)
