require 'pry'
require_relative 'player'
require_relative 'dealer'

class Game

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
           "A^": 10, "A+": 10, "A<3": 1, "A<>": 1
         }
  RISKY = 17.freeze
  attr_accessor :player, :total_cash, :dealer, :card_deck, :bank, :show, :count_add, :count_pass, :count_show_dealer_cards

  def initialize
    @total_cash = 0
    @card_deck = {}
    @dealer = nil
    @player = nil
    @bank = 0
    @show = proc {|cards| puts "The #{self} have cards : #{cards.keys}"}
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
    puts "You take 2 cards:  #{player.cards.keys}"
    2.times{ dealer.cards.merge!(give_card) }
    puts "Dealer take 2 cards:  #{dealer.cards.keys}* * "
    #binding.pry
  end

  def bid
    bid_player = player.cash - player.bid
    bid_dealer = dealer.cash - dealer.bid
    self.bank = bid_dealer + bid_player
    self.total_cash = bank + player.cash + dealer.cash
  end

  def show_cards
    show.call(player.cards)
    show.call(dealer.cards)
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
  end

  def pass
    self.count_pass += 1
  end

  def choise_dealer
    scoring(dealer)
    dealer.cards.merge!(give_card) if dealer.points < 17
  end

  def open_cards
    self.count_add += 1
    self.count_pass += 1
    self.count_show_dealer_cards += 1
    puts "Players cards:  #{player.cards.keys}"
    puts "Dealer  cards:  #{dealer.cards.keys}"
  end

  def scoring(pldl)
      pldl.points = pldl.cards.values.inject do |sum, point|
      sum += point
     end
  end

  # def scoring_player
  #   player.points = player.cards.values.inject{ |sum, point|  sum += point }
  # end

  # def dealer_win
  #   puts "Dealer win :( with #{dealer_points} points vs #{player.points} player points"
  #   self.dealer_cash += bank
  # end
  #
  # def player_win
  #   puts "#{player.name} win !!! with #{player.points} points vs #{dealer_points} dealer points"
  #   player.cash += bank
  # end
  #
  #
  # def scoring
  #   scoring_dealer
  #   scoring_player
  #   self.dealer_points  = 21 - dealer_points
  #   player.points = 21 - player.points
  #   dealer_points < player.points ? dealer_win : player_win
  #
  #   self.dealer_points = 0
  #   player.points = 0
  #   self.bank = 0
  # end
  #
  # def close_to_21
  #   self - 21
  # end
  # def continuation
  #   option = {"1" => begining_game, "2" => "Game over".inspect }
  #   puts "1 - Do you want to play again"
  #   puts "2 - Stop whis game"
  #   response = gets.chomp
  #   option[response]
  # end

  private


end
