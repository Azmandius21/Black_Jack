require 'pry'
require_relative 'game'
require_relative 'player'
require_relative 'show_cards'

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
  loop do
    puts "The game has started!"
    puts "#{name} cash : #{game.player.cash}"
    puts "Dealer cash : #{game.dealer.cash}"
    game.begining_game
    game.bid #player and dealer puts a bid
    game.choise
    gamecount = game.count_add + game.count_pass
    game.choise_dealer 
    game.choise if gamecount < 2
    game.results
    puts "1 - Do you want to play again"
    puts "2 - Stop whis game"
    response = gets.chomp
    break if response == "2"
    game.start_new_round
  end
end
