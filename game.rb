require 'pry'
require_relative 'player'


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
           "A^": [1, 10], "A+": [1, 10], "A<3": [1, 10], "A<>": [1, 10]
         }.freez
  
  RISKY = 17.freez
  attr_accessor :player, :total_cash, :dealer_cash, :cards_in_game,
                        :dealer_cards, :dealer_points, :dealer_bid

  def initialize
    @total_cash = 0
    @dealer_cash = 100
    @cards_in_game = CARD_DECK
    @dealer_cards = {}
    @dealer_points = 0
    @dealer_bid = 10
    @player = nil
  end

  def begining_game
    puts "The game has started!"
    2.times{ player.cards.merge!(give_card) }
    puts "You take 2 cards:  #{player.cards.keys}"
    2.times{ dealer_cards.merge!(give_card) }
    puts "Dealer take 2 cards:  * * "
    #binding.pry
  end

  def second_card_distribution
    puts "Do you need one new card? [Y/N]"
    response = gets.chomp
    player.cards.merge!(give_card) if response =~ /[Yy]/
    choise_dealer
  end

  def choise_dealer
    self.dealer_points = dealer_cards.values.inject{ |sum, point| sum + point }
    dealer_cards.merge!(give_card) if dealer_points < 17
  end

  def give_card
    card_num = rand(cards_in_game.size)
    cards = cards_in_game.to_a
    card = cards[card_num - 1]
    self.cards_in_game.delete(card.first)
    Hash[card.first, card.last]
  end

  private


end
