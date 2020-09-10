INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
NUM_SQUARES = 9
MAX_NUM_WINS = 5
AI_FAILURE_FACTOR = 5

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                 [1, 4, 7], [2, 5, 8], [3, 6, 9], # columns
                 [1, 5, 9], [3, 5, 7]].freeze     # diagonals

WIN_ANIMATION = ['-', '\\', '|', '/'].freeze

WIN_ANIMATION_FRAMES = 16
ANIMATION_REFRESH = 0.1
COMPUTER_MOVE_DELAY = 0.35
GAME_START_DELAY = 2.0

# Input/Output methods
def prompt(msg)
  puts("> #{msg}")
end

def get_input(message, valid_fn, error_msg)
  loop do
    prompt(message)
    result = valid_fn.call(gets.chomp)
    return result.downcase unless result.nil?

    prompt(error_msg)
  end
end

def get_yes_no(message)
  valid_fn = ->(input) { %(yes no).include?(input.downcase) ? input : nil }
  error_msg = 'Sorry, you must enter yes or no. Please try again.'
  get_input(message, valid_fn, error_msg)
end

def valid_int?(str)
  str.match(/^\d+$/)
end

def valid_square?(str, avail_squares)
  valid_int?(str) && avail_squares.include?(str.to_i)
end

def get_square_number(board)
  avail_squares = empty_squares(board)
  valid_fn = ->(input) { valid_square?(input, avail_squares) ? input : nil }
  message = "Choose a square #{joinor(avail_squares)}"
  error_msg = 'Sorry, there is something wrong with your input. ' \
              'Please try again.'
  get_input(message, valid_fn, error_msg).to_i
end

def joinor(arr, delimiter = ', ', final = 'or')
  # Make a copy so we don't mutate the original list
  arr = arr[0..-1]
  if arr.size <= 2
    arr.join(' ' + final + ' ')
  else
    arr[-1] = "#{final} #{arr.last}"
    arr.join(delimiter)
  end
end

def clear_screen
  system('clear') || system('cls')
end

def display_game_delay
  prompt("That's fine. I'll wait.")
  display_computer_thinking
  puts
  prompt("Alright, I'm tired of waiting. Let's start!")
  sleep(GAME_START_DELAY)
end

def display_scoreboard(scores)
  player_score = scores[:player]
  computer_score = scores[:computer]
  winner_indicator = if player_score < computer_score
                       '-|>'
                     elsif player_score > computer_score
                       '<|-'
                     else
                       '-|-'
                     end
  puts(' TIC   TAC   TOE')
  puts('------------------')
  puts('player    computer')
  puts("  #{player_score}    #{winner_indicator}    #{computer_score}")
end

def display_winner(winner)
  puts
  case winner
  when :player then prompt('You won!')
  when :computer then prompt('You lose!')
  when :tie then prompt("It's a tie!")
  end
  puts
end

# rubocop:disable Metrics/AbcSize
def display_board(board, scores)
  clear_screen
  display_scoreboard(scores)
  puts '     |     |'
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts '     |     |'
  puts
end
# rubocop:enable Metrics/AbcSize

def display_computer_thinking
  3.times do
    print('.')
    sleep(COMPUTER_MOVE_DELAY)
  end
end

def display_winning_line(board, winning_line, scores)
  WIN_ANIMATION_FRAMES.times do |i|
    sleep(ANIMATION_REFRESH)
    winning_line.each do |square|
      board[square] = WIN_ANIMATION[i % WIN_ANIMATION.size]
    end
    display_board(board, scores)
  end
end

def single_square_animation(board, square, scores)
  num_frames = WIN_ANIMATION.size
  num_frames.times do |frame|
    sleep(ANIMATION_REFRESH / 1.5)
    board[square] = WIN_ANIMATION[frame % WIN_ANIMATION.size]
    display_board(board, scores)
  end
  board[square] = INITIAL_MARKER
end

def display_tie_animation(board, scores)
  square_order = [1, 2, 3, 6, 9, 8, 7, 4, 5]
  square_order.each { |i| single_square_animation(board, i, scores) }
end

def display_final_winner(scores)
  loss_message = 'You lose! The computer is the champion!'
  win_message = 'You are the champion!'
  message = scores[:player] > scores[:computer] ? win_message : loss_message
  prompt(message)
end

def play_again?(prev_winner)
  loss_message = 'Do you still want to continue after that humiliating ' \
                 'defeat? (yes or no)'
  win_message = 'Do you want to continue? (yes or no)'
  message = prev_winner == :computer ? loss_message : win_message
  get_yes_no(message) == 'yes'
end

# Game board management methods
def initialize_board
  new_board = {}
  (1..NUM_SQUARES).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def num_markers(board)
  markers = board.values
  markers.size - markers.count(INITIAL_MARKER)
end

def place_piece(board, player)
  if player == :player
    prompt("Player's turn")
    square = get_square_number(board)
    board[square] = PLAYER_MARKER
  else
    prompt("Computer's turn")
    display_computer_thinking
    square = computer_strategy(board)
    board[square] = COMPUTER_MARKER
  end
end

def matches_pattern(markers, pattern)
  marker_counts = pattern.keys.map { |m| markers.count(m) }
  marker_counts == pattern.values
end

# The AI is a little too smart and predictable, this will introduce
# a small chance that the AI will 'make a mistake'
def ai_success?(num_markers)
  rand(100) > (num_markers * AI_FAILURE_FACTOR)
end

# AI strategy methods
def find_pattern(board, pattern)
  square = nil
  WINNING_LINES.each do |line|
    markers = board.values_at(*line)
    if matches_pattern(markers, pattern) && ai_success?(num_markers(board))
      square = line[markers.find_index(INITIAL_MARKER)]
    end
  end
  square
end

def find_opportunity(board)
  find_pattern(board, { COMPUTER_MARKER => 2, INITIAL_MARKER => 1 })
end

def find_threat(board)
  find_pattern(board, { PLAYER_MARKER => 2, INITIAL_MARKER => 1 })
end

def pick_five(board)
  5 if board[5] == INITIAL_MARKER
end

def computer_strategy(board)
  choice = find_opportunity(board)
  choice = find_threat(board) if choice.nil?
  choice = pick_five(board) if choice.nil?
  choice = empty_squares(board).sample if choice.nil?
  choice
end

# Game control methods
def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winning_line(board)
end

def detect_winning_line(board)
  WINNING_LINES.each do |line|
    return line if board.values_at(*line).count(PLAYER_MARKER) == 3
    return line if board.values_at(*line).count(COMPUTER_MARKER) == 3
  end
  nil
end

def round_over?(board)
  someone_won?(board) || board_full?(board)
end

def game_over?(scores)
  scores.values.include?(MAX_NUM_WINS)
end

def switch_player(curr)
  curr == :player ? :computer : :player
end

def play_round(board, scores, first_player)
  curr_player = first_player
  loop do
    display_board(board, scores)
    place_piece(board, curr_player)
    break if round_over?(board)

    curr_player = switch_player(curr_player)
  end
  curr_player
end

# gameplay variables
scores = { player: 0, computer: 0 }
first_player = :player
# main game loop
clear_screen
prompt('Welcome to TicTacToe!')
prompt("The first player to win #{MAX_NUM_WINS} rounds is the champion.")
ready = get_yes_no('Are you ready to begin? (yes or no)')
unless ready == 'yes'
  display_game_delay
end
loop do
  board = initialize_board
  last_player = play_round(board, scores, first_player)

  # post-round presentation
  display_board(board, scores)
  winning_line = detect_winning_line(board)
  if someone_won?(board)
    winner = last_player
    scores[last_player] += 1
    display_winning_line(board, winning_line, scores)
  else
    winner = :tie
    display_tie_animation(board, scores)
  end

  clear_screen
  display_scoreboard(scores)
  display_winner(winner)
  first_player = switch_player(first_player)
  break if game_over?(scores)
  unless play_again?(winner)
    prompt('The player has forfeited!')
    scores[:player] = -1
    break
  end
end

display_final_winner(scores)
prompt('Thanks for playing Tic Tac Toe! Goodbye!')
