require_relative 'game'

class Player

  STARTMONEY = 100

  attr_accessor :cash, :bid, :cards, :points
  attr_reader :name

  def initialize(name)
    @name, @cash = name, STARTMONEY
    @cards = {}
    @points = 0
    @bid = 10
  end

  private


end
