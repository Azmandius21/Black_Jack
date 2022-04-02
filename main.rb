require 'pry'
require_relative 'game'
require_relative 'player'

loop do
  #create Game
  game = Game.new

  #addition player to game
  puts "Enter player name"
  name = gets.chomp
  break if name == "quit"
  #binding.pry
  game.player = Player.new(name)
  #gaming
  puts "The game has started!"
  game.begining_game
  game.second_card_distribution
  game.scoring
  game.continuation
end
