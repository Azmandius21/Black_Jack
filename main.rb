
loop do
  #create Game
  game = Game.new

  #addition player to game
  puts "Enter player name"
  name = gets.chomp
  break if name == "quit"
  game.player = Player.new(name)
  #gaming
  game.begigning_game
  game.first_card_distribution
  game.second_card_distribution
  game.scoring
  game.continuation
end
