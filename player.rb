class Player

  STARTMONEY = 100

  def initialize(name)
    @name, @player_cash = name, STARTMONEY
    @player_cards = []
    @player_points = 0
    @player_bid = 10
  end

  private

  attr_accessor :player_cash, :player_bid, :player_cards, :player_points
  attr_reader :name
end
