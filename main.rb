# require 'pry'
require_relative 'game'
require_relative 'player_and_dealer'
require_relative 'show_cards'

loop do
  game = Game.new
  game.create_card_deck
  puts "Enter player name \n(enter 'quit' to escape)"
  name = gets.chomp
  raise 'Invalid name' unless name =~ /\w/
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
    response = gets.chomp
    break if response == '2'

    game.start_new_round
  end
end
