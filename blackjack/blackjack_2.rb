# Black Jack version 2.0

#-----Program Methods Start-----

def display_main_menu
  main_menu_text = <<-MSG 

  Welcome to Black Jack!

  (D)eal a New Hand
  (S)huffle Deck
  (Q)uit

  Please select an option.

  MSG
  puts main_menu_text
end

def display_cards(player_cards, dealer_cards)
  puts "\n"
  print "Player Cards: "
  player_cards.each {|card| print "#{card} "}
  print "\nDealer Cards: "
  dealer_cards.each {|card| print "#{card} "}
  puts "\n\n"
end

def shuffle(unshuffled_deck)
  unshuffled_deck.shuffle
end

def reshuffle_eval(current_deck, full_deck)
  if current_deck.count < 12
    puts 'The deck is being reshuffled.'
    shuffle(full_deck)
  else
    current_deck
  end
end

def deal(player_hand, dealer_hand, deck)
  2.times do
    player_hand << deck.pop
    dealer_hand << deck.pop
  end
end

def hit(hand, deck)
  hand << deck.pop
end

def hand_total(hand)
  hand_total = 0
  hand.each do |card|
    if card == 'K' || card == 'Q' || card == 'J'
      card = 10
    elsif card == 'A'
      hand_total + 11 <= 21 ? card = 11 : card = 1
    end 
    hand_total += card.to_i
  end
  hand_total
end

def keep_score(winner, scores)
  scores[winner] += 1
end

def bust?(hand)
  hand_total(hand) > 21 ? true : false
end

def blackjack?(hand)
  hand_total(hand) == 21 ? true : false
end

def display_blackjack(player_cards, dealer_cards, scores)
  if blackjack?(player_cards)
    puts 'Blackjack!  You win!'
    keep_score(:player, scores)
  elsif blackjack?(dealer_cards)
    puts 'The Dealer has Blackjack!  You lose!'
    keep_score(:dealer, scores)
  elsif blackjack?(player_cards) && blackjack?(dealer_cards)
    puts "You both have Blackjack!  It's a push!"
  end  
end

def dealer_eval(player_cards, dealer_cards, deck)
  while hand_total(dealer_cards) < 15 || hand_total(dealer_cards) < hand_total(player_cards)
    hit(dealer_cards, deck)
  end
end

def display_winner(player_cards, dealer_cards, scores)
  if hand_total(player_cards) > hand_total(dealer_cards)
    puts 'You win!'
    keep_score(:player, scores)
  elsif hand_total(player_cards) < hand_total(dealer_cards)
    puts 'You lose!'
    keep_score(:dealer, scores)
  else
    puts "It's a push!"
  end
end

def display_score(scores)
  puts "Player Score: #{scores[:player]}"
  puts "Dealer Score: #{scores[:dealer]}"
end

#-----Program Methods End-----

#-----Main Program Start-----

DECK = %w(A A A A K K K K Q Q Q Q J J J J 10 10 10 10 9 9 9 9 8 8 8 8 7 7 7 7 6 6 6 6 5 5 5 5 4 4 4 4 3 3 3 3 2 2 2 2)
current_deck = shuffle(DECK)
scores = {player: 0, dealer: 0}

loop do
  current_deck = reshuffle_eval(current_deck, DECK)

  display_main_menu
  user_answer = gets.chomp
  
  case user_answer.upcase
  when 'D'
    player_cards = []
    dealer_cards = []

    deal(player_cards, dealer_cards, current_deck)
    display_cards(player_cards, dealer_cards)
    
    if blackjack?(player_cards) || blackjack?(dealer_cards)
      display_blackjack(player_cards, dealer_cards, scores)
      display_score(scores)
    else
      until user_answer.upcase == 'S'
        puts 'Would you like to (H)it or (S)tand?'
        user_answer = gets.chomp

        if user_answer.upcase == 'H'
          hit(player_cards, current_deck)
          display_cards(player_cards, dealer_cards)
          
          if bust?(player_cards)
            puts "Busted!  You lose!"
            scores[:dealer] += 1
            display_score(scores)
            break
          end
        else
          dealer_eval(player_cards, dealer_cards, current_deck)
          display_cards(player_cards, dealer_cards)

          if bust?(dealer_cards)
            puts "The Dealer busted!  You win!"
            scores[:player] += 1
            display_score(scores)
            break
          end

          display_winner(player_cards, dealer_cards, scores)
          display_score(scores)
          break
        end
      end
    end 

  when 'S'
    current_deck = shuffle(DECK)
  when 'Q'
    break
  else
    puts 'Please select one of the three options above.'
  end
end








