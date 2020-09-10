INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
MAX_NUM_WINS = 5
AI_FAILURE_FACTOR = 6

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                 [1, 4, 7], [2, 5, 8], [3, 6, 9], # columns
                 [1, 5, 9], [3, 5, 7]].freeze     # diagonals

WIN_ANIMATION = ['-', '\\', '|', '/'].freeze

WIN_ANIMATION_FRAMES = 16
ANIMATION_REFRESH = 0.1
COMPUTER_MOVE_DELAY = 0.35

# Input/Output methods
def prompt(msg)
  puts("> #{msg}")
end

def get_input(message, valid_fn, error_msg)
  loop do
    prompt(message)
    input = gets.chomp
    result = valid_fn.call(input)
    return result.downcase if !result.nil?

    prompt(error_msg)
  end
end

def get_yes_no(message)
  valid_fn = lambda do |input|
    %(yes no).include?(input.downcase) ? input : nil
  end
  error_msg = "Sorry, you must enter yes or no. Please try again."
  get_input(message, valid_fn, error_msg)
end

def valid_int?(str)
  str.match(/^\d+$/)
end

def valid_square_choice(str, avail_squares)
  valid_int?(str) && avail_squares.include?(str.to_i)
end

def get_square_number(board)
  avail_squares = empty_squares(board)
  valid_fn = lambda do |input|
    valid_square_choice(input, avail_squares) ? input : nil
  end
  message = "Choose a square #{joinor(avail_squares)}"
  error_msg = 'Sorry, there is something wrong with your input. ' +
              'Please try again.'
  get_input(message, valid_fn, error_msg).to_i
end

def joinor(arr, delimiter=', ', final='or')
  arr_copy = arr[0..-1]
  if arr_copy.size <= 2
    arr_copy.join(' ' + final + ' ')
  else
    arr_copy[-1] = "#{final} #{arr_copy.last}"
    arr_copy.join(delimiter)
  end
end

def clear_screen
  system('clear') || system('cls')
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
  puts(" TIC   TAC   TOE")
  puts("------------------")
  puts("player    computer")
  puts("  #{player_score}    #{winner_indicator}    #{computer_score}")
end

def display_winner(winner)
  puts
  case winner
  when :player then prompt('You won!')
  when :computer then prompt('You lose!')
  when :tie then prompt('It\'s a tie!')
  end
  puts
end

# rubocop:disable Metrics/AbcSize
def display_board(board, scores)
  clear_screen
  display_scoreboard(scores)
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
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
  square_order = [1, 2, 3, 6, 9, 8, 7, 4 ,5]
  square_order.each do |i|
    single_square_animation(board, i, scores)
  end
end

def display_final_winner(scores)
  loss_message = 'You lose! The computer is the champion!'
  win_message = 'You are the champion!'
  message = scores[:player] > scores[:computer] ? win_message : loss_message
  prompt(message)
end

def play_again?(prev_winner)
  loss_message = 'Do you still want to continue after that humiliating ' +
                 'defeat? (yes or no)'
  win_message = 'Do you want to continue? (yes or no)'
  message = prev_winner == :computer ? loss_message : win_message
  get_yes_no(message) == 'yes'
end

# Game board management methods
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def num_markers(board)
  markers = board.values
  return markers.size - markers.count(INITIAL_MARKER)
end

def find_pattern(board, pattern)
  square = nil
  WINNING_LINES.each do |line|
    markers = board.values_at(*line)
    marker_set1 = markers.count(pattern.keys[0])
    marker_set2 = markers.count(pattern.keys[1])
    if marker_set1 == pattern[pattern.keys[0]] && marker_set2 == pattern[pattern.keys[1]]
      square = line[markers.find_index(INITIAL_MARKER)]
      # The AI is a little too smart and predictable, this will introduce
      # a small chance that the AI will 'make a mistake'
      square = nil if rand(100) < (num_markers(board) * AI_FAILURE_FACTOR)
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
  choice = find_threat(board) if choice == nil
  choice = pick_five(board) if choice == nil
  choice = empty_squares(board).sample if choice == nil
  choice
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
  scores[:player] == MAX_NUM_WINS || scores[:computer] == MAX_NUM_WINS
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
  if !play_again?(winner)
    scores[:player] = -1000
    break
  end
end

display_final_winner(scores)
prompt('Thanks for playing Tic Tac Toe! Goodbye!')
