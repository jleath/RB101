require 'pry'
require 'byebug'
# 1. Initialize Deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#    - repeat until bust or 'stay'
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#    - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

# Dealer and player hands  will be stored as arrays.
# The deck will be an array of arrays, the subarrays will be the cards.
#   These subarrays will contain two strings, the suit and value of the card.
#   We won't be using the suit but it's still wortwhile to build a real 'deck'.

SUITS = %w(hearts diamonds clubs spades).freeze
FACE_CARDS = %w(J Q K).freeze
ACE = 'A'.freeze
VALUES = (%w(2 3 4 5 6 7 8 9 10) + FACE_CARDS + [ACE]).freeze
BUST_VALUE = 21
DEALER_STOP = 17
VALID_PLAYER_ACTION = %w(hit stay).freeze
NUM_INITIAL_CARDS = 2

def prompt(msg)
  puts("> #{msg}")
end

def clear_screen
  system('clear') || system('cls')
end

def get_input(message, valid_fn, error_msg)
  loop do
    prompt(message)
    result = valid_fn.call(gets.chomp)
    return result.downcase unless result.nil?

    prompt(error_msg)
  end
end

def display_hand_info(hand, dealer, game_end = false)
  clear_screen
  hand_string = hand.map { |card| value(card) }.join(' ')
  dealer_string = dealer.map { |card| value(card) }.join(' ')
  if game_end
    prompt("Dealer: #{dealer_string}")
  else
    prompt("Dealer: #{value(upcard(dealer))}")
  end
  puts
  puts
  prompt("Player: #{hand_string}")
end

def get_player_action
  valid_input_fn = lambda do |input|
    VALID_PLAYER_ACTION.include?(input.downcase) ? input : nil
  end
  error_msg = 'Sorry, that is not a valid option. Try again.'
  message = 'Would you like to hit or stay? (Type hit or stay)'
  action = get_input(message, valid_input_fn, error_msg)
  case action
  when 'hit' then :hit
  when 'stay' then :stay
  end
end

def display_intro
  clear_screen
  prompt('Welcome to TwentyOne!')
  prompt('You and the dealer will each get two cards.')
  prompt("You'll see both of your cards but only one of the dealer's cards.")
  prompt("Hit to take another card or stay to stop taking cards.")
  prompt("If the value of your cards surpasses 21, you automatically lose!")
  prompt("Whoever has the most valuable hand at the end wins!")
  prompt("Ready? Press the enter key to start!")
  gets.chomp
end

# Deck Abstraction
def build_deck
  deck = []
  SUITS.each do |suit|
    VALUES.each do |val|
      deck << card(val, suit)
    end
  end
  deck
end

def hand_value(hand)
  points = 0
  aces = []
  hand.each do |card|
    ace?(card) ? aces << card : points += point_value(card, points)
  end
  aces.each do |ace|
    points += point_value(ace, points)
  end
  points
end

def add_card!(card, hand)
  hand << card
end

# For now, assume there are cards left in the deck
def draw_card!(deck)
  card_index = rand(deck.size - 1)
  deck.delete_at(card_index)
end

# Card Abstraction
def card(val, suit)
  [val, suit]
end

def suit(card)
  card[1]
end

def value(card)
  card[0]
end

def ace?(card)
  value(card) == ACE
end

def face_card?(card)
  FACE_CARDS.include?(value(card))
end

def numeral_card?(card)
  !!value(card).match(/^\d+$/)
end

def point_value(card, hand_total, ace_limit=BUST_VALUE)
  if numeral_card?(card)
    value(card).to_i
  elsif face_card?(card)
    10
  else
    (hand_total + 11) > ace_limit ? 1 : 11
  end
end

def busted?(hand)
  hand_value(hand) > BUST_VALUE
end

# Gameplay methods
def players_turn(hand, dealer, deck)
  loop do
    display_hand_info(hand, dealer)

    action = get_player_action
    break if action == :stay

    case action
    when :hit then add_card!(draw_card!(deck), hand)
    end

    break if busted?(hand)

  end
end

def dealer_stop?(hand)
  hand_value(hand) > DEALER_STOP
end

def dealers_turn(hand, deck)
  loop do
    break if dealer_stop?(hand)

    add_card!(draw_card!(deck), hand)
  end
end

def upcard(hand)
  value(hand[0])
end

def deal_first_cards!(players_hand, dealers_hand, deck)
  NUM_INITIAL_CARDS.times do
    add_card!(draw_card!(deck), players_hand)
    add_card!(draw_card!(deck), dealers_hand)
  end
end

display_intro
dealers_hand = []
players_hand = []
deck = build_deck
deal_first_cards!(players_hand, dealers_hand, deck)
players_turn(players_hand, dealers_hand, deck)
dealers_turn(dealers_hand, deck)
display_hand_info(players_hand, dealers_hand, true)