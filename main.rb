# require 'pry'
require_relative 'game'
require_relative 'player_and_dealer'
require_relative 'show_cards'

loop do
  game = Game.new
  puts "Enter player name \n(enter 'quit' to escape)"
  name = gets.chomp
  break if name == 'quit'
  game.player = Human.new(name)
  game.dealer = Human.new('Dealer')
  loop do
    puts 'The game has started!'
    game.all_person_cash
    game.begining_game
    gamecount = game.count_add + game.count_pass
    game.choise if gamecount < 2
    game.results
    game.all_person_cash
    puts "Do you want to play again\n1 - Continue current card game\n2 - Stop whis game"
    if game.player.cash < 0
      response = "2"
      puts "#{game.player.name} lost all cash"
    elsif game.dealer.cash < 10
      response = "2"
      puts "Dealer lost all cash"
    else
      response = gets.chomp
    end
    break if response == '2' || 
    game.start_new_round
  end
end
