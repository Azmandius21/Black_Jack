require 'pry'
require_relative 'player'
require_relative 'dealer'
require_relative 'reset'

class Game
  include Reset

  CARD_DECK = {"2^": 2, "2+": 2, "2<3": 2, "2<>": 2,
           "3^": 3, "3+": 3, "3<3": 3, "3<>": 3,
           "4^": 4, "4+": 4, "4<3": 4, "4<>": 4,
           "5^": 5, "5+": 5, "5<3": 5, "5<>": 5,
           "6^": 6, "6+": 6, "6<3": 6, "6<>": 6,
           "7^": 7, "7+": 7, "7<3": 7, "7<>": 7,
           "8^": 8, "8+": 8, "8<3": 8, "8<>": 8,
           "9^": 9, "9+": 9, "9<3": 9, "9<>": 9,
           "10^": 10, "10+": 10, "10<3": 10, "10<>": 10,
           "J^": 10, "J+": 10, "J<3": 10, "J<>": 10,
           "Q^": 10, "Q+": 10, "Q<3": 10, "Q<>": 10,
           "K^": 10, "K+": 10, "K<3": 10, "K<>": 10,
           "A^": 10, "A+": 10, "A<3": 10, "A<>": 10
         }
  RISKY = 17.freeze
  attr_accessor :player, :total_cash, :dealer, :card_deck, :bank, :show, :count_add, :count_pass, :count_show_dealer_cards

  def initialize
    setup_new_game
    @show = proc {|cards, owner| puts "#{owner} have cards : #{cards.keys}"}
  end

  def setup_new_game
    @total_cash = 0
    @card_deck = {}
    @dealer = nil
    @player = nil
    reset_current_session!
  end

  def start_new_round
    reset_current_session!
    player.reset_points_and_cards!
    dealer.reset_points_and_cards!
  end

  def reset_current_session!
    @bank = 0
    @count_add = 0
    @count_pass = 0
    @count_show_dealer_cards = 0
  end
  # show = proc {|cards| puts "The #{self} have cards : #{cards.keys}"}
  # show.call(player.cards)
  # show.call(dealer.cards)

  def create_card_deck
    CARD_DECK.keys.each{ |key| self.card_deck[key] = CARD_DECK[key] }
  end

  def give_card
     card_num = rand(card_deck.size) - 1
     cards = card_deck.to_a
     card = cards[card_num]
     #binding.pry
     self.card_deck.delete(card.first)
     Hash[card.first, card.last]
  end

  def begining_game
    2.times{ player.cards.merge!(give_card) }
    puts "#{player.name} take 2 cards:  #{player.cards.keys}"
    2.times{ dealer.cards.merge!(give_card) }
    puts "Dealer take 2 cards:  * * "
    #binding.pry
  end

  def bid
    player.cash -= player.bid
    dealer.cash -= dealer.bid
    self.bank = player.bid + dealer.bid
    self.total_cash = bank + player.cash + dealer.cash
  end

  def choise
    options = { "1" => :pass, "2" => :add, "3" => :open_cards }
    puts "What do you want to do?"
    puts "Pass - 1" if count_pass == 0
    puts "Add card - 2" if count_add == 0
    puts "Open cards - 3"
    response = gets.chomp
    send options[response]
  end

  def add
    player.cards.merge!(give_card)
    self.count_add += 1
    player.show_cards(player.name)
  end

  def pass
    self.count_pass += 1
  end

  def choise_dealer
    scoring(dealer)
    dd = dealer.cards.size
    dealer.cards.merge!(give_card) if dealer.points < 17
    puts "Dealer taked 1 card" if dealer.cards.size > dd
  end

  def open_cards
    self.count_add += 1
    self.count_pass += 1
    #self.count_show_dealer_cards += 1
    player.show_cards(player.name)
    dealer.show_cards('Dealer')
  end

  def scoring(participant)
      participant.points = participant.cards.values.inject do |sum, point|
      sum += point
     end
     participant.cards.keys.each do |card|
       if card =~/[A]/
        participant.points -= 9 if participant.points > 21
       end
     end
     participant.points
  end

  def results
    points_dealer = scoring(dealer)
    points_player = scoring(player)
    player.show_cards(player.name)
    dealer.show_cards('Dealer')
    puts "Players score: #{points_player}"
    puts "Dealer score: #{points_dealer}"
    if points_dealer == points_player
      puts "dead heat"
      player.cash += bank/2
      dealer.cash += bank/2
    elsif points_dealer > 21
      puts "dealer to much"
      player.cash += bank
    elsif points_player > 21
      puts "player to much"
      dealer.cash += bank
    elsif points_player > points_dealer
      puts "player win"
      player.cash += bank
    else
      puts "dealer win"
      dealer.cash += bank
    end
  end

  private


end
