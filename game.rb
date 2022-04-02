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
           "A^": 10, "A+": 10, "A<3": 1, "A<>": 1
         }
  RISKY = 17.freeze
  attr_accessor :player, :total_cash, :dealer_cash, :cards_in_game,
                        :dealer_cards, :dealer_points, :dealer_bid, :bank

  def initialize
    @total_cash = 0
    @dealer_cash = 100
    @cards_in_game = CARD_DECK
    @dealer_cards = {}
    @dealer_points = 0
    @dealer_bid = 10
    @player = nil
    @bank = 0
  end

  def begining_game
    2.times{ player.cards.merge!(give_card) }
    puts "You take 2 cards:  #{player.cards.keys}"
    2.times{ dealer_cards.merge!(give_card) }
    puts "Dealer take 2 cards:  #{dealer_cards.keys}* * "
    #binding.pry
  end

  def second_card_distribution
    puts "Do you need else one card? [Y/N]"
    response = gets.chomp
    player.cards.merge!(give_card) if response =~ /[Yy]/
    choise_dealer
    open_cards
  end

  def choise_dealer
    scoring_dealer
    dealer_cards.merge!(give_card) if dealer_points < 17
  end

  def give_card
    card_num = rand(cards_in_game.size)
    cards = cards_in_game.to_a
    card = cards[card_num - 1]
    self.cards_in_game.delete(card.first)
    Hash[card.first, card.last]
  end

  def open_cards
    puts "Players cards:  #{player.cards.keys}"
    puts "Dealer  cards:  #{dealer_cards.keys}"
  end

  def scoring_dealer
    self.dealer_points = dealer_cards.values.inject do |sum, point|
      sum += point
    end

  end

  def scoring_player
    player.points = player.cards.values.inject{ |sum, point|  sum += point }
  end

  def dealer_win
    puts "Dealer win :( with #{dealer_points} points vs #{player.points} player points"
    self.dealer_cash += bank
  end

  def player_win
    puts "#{player.name} win !!! with #{player.points} points vs #{dealer_points} dealer points"
    player.cash += bank
  end


  def scoring
    scoring_dealer
    scoring_player
    self.dealer_points  = 21 - dealer_points
    player.points = 21 - player.points
    dealer_points < player.points ? dealer_win : player_win

    self.dealer_points = 0
    player.points = 0
    self.bank = 0
  end

  def close_to_21
    self - 21
  end
  def continuation
    option = {"1" => begining_game, "2" => "Game over".inspect }
    puts "1 - Do you want to play again"
    puts "2 - Stop whis game"
    response = gets.chomp
    option[response]
  end

  private


end
