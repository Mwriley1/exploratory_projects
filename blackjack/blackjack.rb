#Black Jack v 1.0

def center_string(string)
  string.center(100)
end

def display_table_menu
  puts center_string('Select from the following options:')
  puts ' '
  puts center_string("'D' to deal a new hand")
  puts center_string("'S' to shuffle the deck")
  puts center_string("'Q' to quit")
  puts ' '
end

def shuffle_deck(deck)
  deck.shuffle!
end

def deal_card(deck)
  deck.shift
end

def deal_hand(deck, player_cards, dealer_cards)
  2.times do |i| 
    player_cards << deal_card(deck)
    dealer_cards << deal_card(deck)
  end 
end

def display_cards(player_cards, dealer_cards)
  dealer_cards_showing = ['?'] + [dealer_cards[1]] 
  puts center_string("Player Cards: #{player_cards}")
  puts center_string("Dealer Cards: #{dealer_cards_showing}")
end

def hit(player_cards, deck)
  player_cards << deck.shift
end

deck = %w(A A A A K K K K Q Q Q Q J J J J 10 10 10 10 9 9 9 9 8 8 8 8  7 7 7 7 6 6 6 6 5 5 5 5 4 4 4 4 3 3 3 3 2 2 2 2)
shuffle_deck(deck)

loop do
  puts ' '
  puts center_string('Welcome to Black Jack!')
  puts center_string("Enter 'S' to sit at a table or 'Q' to quit.")
  main_menu_ans = gets.chomp.upcase
  
  if main_menu_ans == 'S'
    puts center_string('Welcome to the table!')
    puts ' '
    display_table_menu
    table_menu_ans = gets.chomp.upcase

    case table_menu_ans
    when 'D'
      player_cards = []
      dealer_cards = []

      deal_hand(deck, player_cards, dealer_cards)
      display_cards(player_cards, dealer_cards)

      puts center_string("Enter 'H' to hit or 'S' to stay")
      hit_or_stay_ans = gets.chomp

      if hit_or_stay_ans.upcase == 'H'
        hit(player_cards, deck)
        display_cards(player_cards, dealer_cards)
      end

    when 'S'
      shuffle_deck(deck)
    when 'Q'
      break
    end

  elsif main_menu_ans == 'Q'
    break
  else
    puts center_string('That is not a valid choice.')
  end

end


