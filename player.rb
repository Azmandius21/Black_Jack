require_relative 'game'

class Player

  STARTMONEY = 100

  attr_accessor :player_cash, :player_bid, :cards, :player_points
  attr_reader :name

  def initialize(name)
    @name, @player_cash = name, STARTMONEY
    @cards = {}
    @player_points = 0
    @player_bid = 10
  end

  private


end
