require 'pry'
require_relative 'game'
require_relative 'player'

loop do
  #create Game
  game = Game.new
  game.create_card_deck
  #addition player to game
  puts "Enter player name"
  name = gets.chomp
  break if name == "quit"
  game.player = Player.new(name)
  game.dealer = Dealer.new
  #gaming
  puts "The game has started!"
  game.begining_game

  game.bid #player and dealer puts a bid
  #game.show_cards
  # game.second_card_distribution
  game.choise
  game.count = game.count_add + game.count_pass
  #game.show_cards
  game.choise_dealer if game.count_show_dealer_cards == 0
  game.choise if game.count < 2
  binding.pry

  game.show_cards if game.count == 2
  # game.scoring
  # game.continuation
end
